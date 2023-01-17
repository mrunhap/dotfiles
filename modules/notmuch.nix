{ config, pkgs, ... }:

# TODO
{
  programs = {
    notmuch = {
      enable = true;
      new.tags = [ "new" ];
      hooks = {
        preNew = "afew -m; mbsync -a;";
        postNew = "afew -tn";
      };
    };

    mbsync = {
      enable = true;
    };

    afew = {
      enable = true;
      extraConfig = ''
# ~/.config/afew/config
# 所有新邮件会从上至下经过所有规则

# 邮件所在文件夹是什么名字，就打上什么 tag
[FolderNameFilter]
# 子文件夹分隔符： /
# github/receipt 会被打上两个Tag： +github +receipt
maildir_separator = /
# 以下文件夹不加 tag
folder_blacklist = Archive INBOX
# 所有文件夹名先转小写再打 Tag
folder_lowercases = true

# 被邮件服务器打上 Spam 标记的邮件： +junk
[SpamFilter]
spam_tag = 'junk'

# 有一个极其活跃的讨论串，但内容我不感兴趣
# 因此我给这个串 +killed
# 接下来这个讨论串的新增讨论都会被自动 +killed
[KillThreadsFilter]

# 邮件 Headers 里的 List-Id： +lists/list-id
# 对订阅的邮件列表极其有用
# 比如 emacs-devel 邮件列表会被加上 lists/emacs-devel
[ListMailsFilter]

# 我自己已发送的邮件不打 tag
[ArchiveSentMailsFilter]

# To 给我的邮件： +to-me
[MeFilter]

# 在 INBOX 文件夹里： +inbox
[InboxFilter]

# 其他预置 filter 或自定义 filter：
# https://afew.readthedocs.io/en/latest/filters.html

[MailMover]
# 要列出所有涉案的本地 maildir
folders = 'gmail/INBOX' 'gmail/Junk' 'gmail/Archive' 'gmail/Sent'
rename = True

# xx 天之前的邮件不移动
# max_age = 15

# 规则：等号左边 dir 里的邮件，如果满足引号左边的搜索条件，则被移动到冒号右边的 dir
# 注意：如果一个邮件同时符合多个搜索条件，它会被复制多份至所有符合条件的 maildir
# 至于为什么，有过讨论：
# https://github.com/afewmail/afew/issues/242
# 这就是为什么这里写得这么死板
# 当然你可以把它当作一个 feature 加以利用
gmail/INBOX = 'tag:junk':gmail/Junk 'NOT tag:inbox AND NOT tag:junk':gmail/Archive
gmail/Junk = 'NOT tag:junk AND tag:inbox':gmail/INBOX 'NOT tag:junk':gmail/Archive
gmail/Archive = 'tag:inbox AND NOT tag:junk':gmail/INBOX 'tag:junk':gmail/Junk
gmail/Sent = 'NOT tag:sent':gmail/INBOX
      '';
    };
  };
}