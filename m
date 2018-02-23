Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250LPXbBXUke7m9atCzmgjAeRIRTVfVaYK+jIbZdHsWL3R8UZlIQHqrOyh3LwL9eB/6DBw1
ARC-Seal: i=1; a=rsa-sha256; t=1519410710; cv=none;
        d=google.com; s=arc-20160816;
        b=AA38OtyBqeH/VGGSbBmIkSzHpGTHzpziFA8A+WKYDHy2SMuGxHIJFLJqNh4U+oGq/n
         l1TdiOZwKdVuuyq6idgZTZm+Utxbp9hik4CCim3rXIP1bPU/uLqjnkC9YXcptm1c0lER
         CCYDxrgn5uQNHydFBuhVfmsveg+0wRVvrtIaY4oyljYjUAha8Uh+HksIKoZrLOj73nU0
         9ufznaA3m4UXKc1kWmlIj/26sIsunZ6aohVTium11ZGGOeLUi0DNFsj58cB6Jn+F5hH5
         rYuHiIU9jw0j6BYrGeLi8KiAR3f18O4i4F4tNPah51OeCc6Vps3H/TtaQPVK6YfKCVGs
         hN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ddh2aFybwfHI/j6gO9lEAx/ix1SKQ03Qvc8P3WxsPy0=;
        b=oi6uTmpsfIqGZRmBEwia93W7wPz581pJNhaweuz2hQkVvzRxjBkegn6wXavVBIafPP
         AEs5EMokniNC6FgMVsYB/ywEMWkurzYMPzwwmq0HXoHCzGMXlB5hVUu5OZurHmhFK/pL
         2Yr0qFljDZml0Ifwuv89YF1aOgxopZ+rnhJNl05ozNq1uExxlznHV9aAl4NecQY4DaHl
         fZv9pkSYfbKrKOkb76vRYFaZGuMR3fV3K0+/h7EiNCdtopkAUo4TmSNM9lW78ou49vgy
         ykn6gd5DjF1dnVVLiujxApEB/nQ0yJbHh0uJEPvrR0rIZIp8NPBjNcCH7e0F9XOkpfMw
         eJQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" <ernesto.mnd.fernandez@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 3.18 10/58] ext4: correct documentation for grpid mount option
Date: Fri, 23 Feb 2018 19:26:09 +0100
Message-Id: <20180223170208.299090218@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217604878479954?=
X-GMAIL-MSGID: =?utf-8?q?1593217604878479954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

commit 9f0372488cc9243018a812e8cfbf27de650b187b upstream.

The grpid option is currently described as being the same as nogrpid.

Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/filesystems/ext4.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/filesystems/ext4.txt
+++ b/Documentation/filesystems/ext4.txt
@@ -233,7 +233,7 @@ data_err=ignore(*)	Just print an error m
 data_err=abort		Abort the journal if an error occurs in a file
 			data buffer in ordered mode.
 
-grpid			Give objects the same group ID as their creator.
+grpid			New objects have the group ID of their parent.
 bsdgroups
 
 nogrpid		(*)	New objects have the group ID of their creator.
