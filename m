Return-Path: <Rene.Hickersberger@gmx.at>
X-Google-Smtp-Source: AG47ELvjiJODEedTMidWWepvBsV3G5je8QgtEwkPoaliBUzwprv/pZMyIPDnAKMBr8JwyrynozMh
ARC-Seal: i=1; a=rsa-sha256; t=1522070910; cv=none;
        d=google.com; s=arc-20160816;
        b=aPwCyJc7zJ5E3EnaMubdnJu4HuhvgOdeasXVupYKDImCuPOpzVaMdyWUg4xp0JCq+6
         m450r2GxjtdrUBz+VOtTzQ12gu22ax1J32Lxw8aToFYxhfZyE3MjgXW7ui0VwaVKv3k3
         cbbP0oVwnk1VrLmv355l0B7REh7ocP1wJoeN86MWpP6ysyVUcF0IHpDDQNz2436DiBmO
         McmOoJsp3h4EAtnMOT6ckPAnrsEew4tZc4MaJbRl+ew6UMGo77kWhYVG67stqLC5AyxG
         knbZzmtFf2smJ+uy3TGWCpR8CJb3z2M00t0wJhTdKSkACcrTIgICQSAB0aVLKyaUNx5O
         E9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=AVnttGM63VXgzrjiKmx1E2+B+2M+pIfdm0bAbN4hrGQ=;
        b=L780n7ok+kUp5piRy8jIDNQ21ivJvF8vPHXPlVTiW/AbF6W4JsuHsYQ696x/2dLRxo
         KMAFqX64wQseW3ykhmGYOlRtaJ0RNH5zpnqNrBbuQgEVPCwTcVOfP+c47TDA4yZC1Bod
         sCO1LEMypme/5UMfu+zZDelJTM3fkhGTs16i2uz0NoUCgV+DaHGbi8cJYc2V4hVXlhv3
         zg674hPzFupj8ARqS110CGaCnc1U5QbjLUoY4r56GHdTpdnPJPWx7rsjQDV4tNF4s8Pl
         OJyGolVvqGi1HfdXnbmpEL+sWG9G7RXlKALRWpDMGLjMQj6VcS7vOwOIkIAY5CaUUy4Z
         HThQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rene.hickersberger@gmx.at designates 212.227.17.21 as permitted sender) smtp.mailfrom=Rene.Hickersberger@gmx.at
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rene.hickersberger@gmx.at designates 212.227.17.21 as permitted sender) smtp.mailfrom=Rene.Hickersberger@gmx.at
From: Rene Hickersberger <Rene.Hickersberger@gmx.at>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Rene Hickersberger <Rene.Hickersberger@gmx.at>
Subject: [PATCH] Staging: comedi: ni_stc: Fixed comment coding style issue
Date: Mon, 26 Mar 2018 15:27:10 +0200
Message-Id: <1522070830-11621-1-git-send-email-Rene.Hickersberger@gmx.at>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K0:hz9+ZkvgcxJOKQ5uP9ojG9zIHq2lyptHzwa2GZTvOvwI6thHVee
 rKAGCez3qJGfmmRGJDTQ8iZYCGeZKNPF/C9Zd7WvstOUOT6LOsXcNKUTLKZerPFw4QzXiW8
 Bnjl6w0XVk+mImqfirdb/88c4WwAVMMJfjxB0JXuVBLhgCHtkj49xqrxrWi0QXJ9AF9whHW
 yLtKaDsoaep4/G0CQKQFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t1wE/1jZRW0=:06HxOsg87KDGzEgNz5EUxw
 lmpTpQiLNXPLOGwItgBuMP+WbjKf9l31z/Z1TZhj2tbykhoE+hD47xIY7t7Pbh1T4S0P6K/FA
 B2d5FXql3prMGhetgXhQOx8pUQtGbQqKWYuYyZA7DlKQNbrscr4XEElfceXkdSvKxmMLueWvV
 Qvw8p8+CJ/rIe78HbqPMwDwILUeJB6Wp0mXVSKqm2dRgbcYt1adjheWlpx5Oj2gbKHSPzGy6A
 UXhBFSh7KSMADMK2AGI9jebFjD52LtZHxlqQTGudhSpoWuGZZqJT9tdl1QkpBhq94JJNU+xlm
 7zLlhE0ss8t8kV+mWnMky7xRhNgP2PNqxWkZE4d2moei8RJkOg7UtmiDqyv/er0VOawIKzASK
 yfTD2iJ/VwReJtmH2QdmtkF8FfxtvuVz0dD/9KLIu4vO7eFv6sjVFgrX9PE7fnWNXmtltixL6
 VPNlYR6R0cKj5b9bcPnH9MJZp6O5CLWoDUc7ric3fUlF7HOP2rXZoB+7ZHgFJREZ37/fZfZ4u
 RpiWVlXBfRa5sJZuKp/y9sPftsGcAEdxwNJc3BpqueybS7kAMBLB7nyb1XR3IsttgDNzGntP5
 zSVrtIVrEhKkwnsI1UAVCpsb6dt9R3Ua5O0zQ0IB+oWxb5ewrCCXMcM1zTwAo8gys4U1xgrSG
 BuX/GS0X5KpfhxrOjaTXPf+osXOaF/ln57iXqJzuUCuRdO8yInShf3Iw+SadBtTLJoos7yj/m
 qXtI42vCsSYUkSbLwCi0xgplUhQTkXCh4xmG7w64aN6XnkHZ5zzbk2EfTXFLg1FZXEN0eL9v1
 KdfVzC8atCbD0BgOHOupOOKcli5Ow==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596007026650061998?=
X-GMAIL-MSGID: =?utf-8?q?1596007026650061998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed a coding style issue where the comment * was not aligned.

Signed-off-by: Rene Hickersberger <Rene.Hickersberger@gmx.at>
---
 drivers/staging/comedi/drivers/ni_stc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/comedi/drivers/ni_stc.h
index cb9d4c3..831088c 100644
--- a/drivers/staging/comedi/drivers/ni_stc.h
+++ b/drivers/staging/comedi/drivers/ni_stc.h
@@ -9,7 +9,7 @@
 /*
  * References:
  *   DAQ-STC Technical Reference Manual
-*/
+ */
 
 #ifndef _COMEDI_NI_STC_H
 #define _COMEDI_NI_STC_H
-- 
2.7.4
