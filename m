Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ewgzqhnUcUqBiuI/z3K24sQvm4t4vtoJJknsraxbKdL4hT5DcxEv1rU/2AuJGDSyNeadG
ARC-Seal: i=1; a=rsa-sha256; t=1519217131; cv=none;
        d=google.com; s=arc-20160816;
        b=VVsfZO/QoymptNvjWE2Aw1mq/2/ytuMG6IAO2FAHDrjspjoQemiXeCrJ6GGeu/dsTK
         LbQSzaBrLpK26uO6GriS4dxp6ZE45JWz/VmuyJPeQSIPlTlqLPik5z1/4zYOg0YgUFu2
         MQI2QSUdeqIDBKXie6IOf+i2hf4DH2XYeihHhknyEU7Tkx5FPO87K+iqVKHUpBMQlRV6
         rbqz6QtE0Ulrs4hpSAgssJVgpchOnR3dqdpTPJIY1GHablr2i5oWKOCdjuiXuEY5wMFO
         J5uKc1J4K5ig6eOh0jAJPlLzI34lHYyTWezen2suUdwOuVs7/OyBG+J7/RMVX2Gw8JGV
         IoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VIOrkYLLWFYJCPkHu8LYSzZrvUG6lLCC0cupBU2mrsE=;
        b=tB/i7rMxHdo7EXT8hAcfyOxWvAaziH41uSndZP/7xc1Eh+Q7rRr99fKaMAk0oixRo7
         M+8OjG+THfjOG4gbm6NLUBAaXFB6UgQ+/F8ruoLqNzM0cKNQ39oAVgYFISaqk7Y7stFP
         0LrdlxYnn4Xex8Xjfe3tciiZ9a/W9hO5t/7lZVgVBMUSf1tV++6FPyRxw+gBpDGAJl5I
         jbcLT4JMvTG0C0Bi7hdGuMmnJRxwqgkgx/JQX6CqtP5RRagMlcFyhQ7d8RJPHuehDH+Z
         Ca7cxv0RddHUn0XLCILF2dzXqy7LPWDoRBvw/5fqUEBl/JcGqvX8EcpAytdeohd7IN+m
         cg0A==
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
Subject: [PATCH 4.4 14/33] ext4: correct documentation for grpid mount option
Date: Wed, 21 Feb 2018 13:44:57 +0100
Message-Id: <20180221124410.402826757@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014623261123447?=
X-GMAIL-MSGID: =?utf-8?q?1593014623261123447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
