Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224gQnKhaPx3Mock5uXy3lL7fTBd0dC0ljrnYAyZWPmp8JLy+GNRFJrL4wrlWpe8ZwUcUFPC
ARC-Seal: i=1; a=rsa-sha256; t=1519218236; cv=none;
        d=google.com; s=arc-20160816;
        b=fHZBr0Ga6AU8JdqNf6rVnr3V69XzvXYmF4ItYHmA8uaSybfMEFq+o+M7UIKg77Z8TV
         zV505wk6BrnhsvNyLK8x9hSP4U8Cq6sD8b04GXn7fic7fx0yqH44lIWtjnvsaE12zcKq
         x4JeS1/et3ExgdPgzrNBqForti8AWYNXF2TYYjbFdYHzmL30/w2EOF+WAr1OTtBDeU8M
         TfE2X/bXK7MhLQpMfIFJzbkAg25SmZVRPZZwouv72oXK9e7S/tNpqaE1FdMsiOeb9+Ry
         reEWF3JScp2k6m+xZGX7kWKWBuAfTO8pUQBHP+7Ug8E0m+5kB5FUATy+ydL6qggmwkwU
         s6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8u97v9IjgkcaflVkZq0BKm5aWg92tvkogK6tcMEKPYk=;
        b=t4KHM66Q6FzlUsXmOPWGnvUs4H93PWVr175mWvmqTO1FzHwkBNvBiV1NvKvRCJEvcS
         NTOtmajlqbHVyTb9LuE7eMK/jvAJfnYS7Shbg/rxYs61sEwcER1+iCwv+VS2YVSURNuP
         WYyaxBmIK2CkJEmQrP3JpKrdm0UaqOULYIecy+SJluQ/JRPB5FQ3Etn5DNX11X6/qlQM
         0/TaiQB1Bg94da/dvT7rdwwvoGsJkUhsRTUnUq9BL/N+fSPP+RK5n6/i9GT2zIuMUiTY
         ICXxMj/hlo0icWzkfJaYVHzIT2eXLJyR6iK8OhyfXmqeYEp2Dknz6K1pdcFVFbGMMB2C
         KnFw==
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
Subject: [PATCH 4.14 108/167] ext4: correct documentation for grpid mount option
Date: Wed, 21 Feb 2018 13:48:39 +0100
Message-Id: <20180221124530.281585368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015282752811367?=
X-GMAIL-MSGID: =?utf-8?q?1593015781766807672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
