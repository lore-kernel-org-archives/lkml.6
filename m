Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x227mrbUVdw7gfhQV//91hb8/gAJ3lUcbHgfrXfnTweAGsi7bbURL2wQWHakA0nC2GD9Q0A+o
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=Urgevfc+h2F93ucjRXkQNJXZnI/lFZk+8xU7c9nF4aezAu6AThnn2VU/VZ+P8DpQj3
         oIR1RLeo1zblzEbJ0uUH0I//IZ/JBzJmmmY9lFQxaI5s1XAKM3uSJ2bpudLjKwk2fsU3
         o1NhOxe2qULG+OQ1HrLZImCZJvL+mZVu3YyEEC68ZIfP0Zj2NyF9xkrkKQGhzPfdgxFS
         gJzvdTAoyXAmV1oF+L0ApRRji+7DEfrCbae9BdKD18sskaLA/3VBacJA+vL6fvXpPP3L
         KVg2CDgVP1mT/YjOOGbGiRCQJ0j9jXYqBvusBDk2NQyMU1HFsSGGNetKsYayzhlSTqKM
         bIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2fOXktozMO7zWLbzSsrdATwYXICExJKsB46ySel3r58=;
        b=kcyWdFJ2XnmiYfThkQ+jqdOL9nfFZZO1XZfH7XZBD9GKC9p1h4C5DyDNJs5vnM0LNi
         M4foSh9oIKpwOjUxifuh5vSIAhupxBIGiycEHdLJ+Xw5PH5pfHo2ok6qD2QAP3aHNEj6
         PYGOuCOkmizMCsxG1jtlo3vXlwvbxMAmdx0YW+4I9vOP5q5ri/hbM0beRoEvp432tbQc
         cLZVI71wQDq854br7Y4dTWzvSielcFPOhhXgLrjZpEJT3MGtyCEjZJLM55mLMbu38TFo
         D3iipfT8Mh2//AuefRd5r3vK797ubP4Y+gGTBuDGiPtQpZpJKYVfr39DqDGpzBc8m42X
         BdHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: Joe Perches <joe@perches.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/12] hv: Synthetic typo correction
Date: Sun, 11 Feb 2018 17:33:11 -0700
Message-Id: <20180212003320.6748-3-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGfLzs+4lIQQWJS3NtKpuQDQuHn6mJDvI/GoOSSpt2MSgqIXmewL8IWLJmo6NT35dOTufmrQS9/yvCCZHM96bNQSVvdUsFqUepL8T+h4MZqkl5VZYetC
 z4ixOdZdd5j28Q7tUcvxTKEEtpKJ8bcgRypNjPQIQrxYV4Y6igIOQF/QP7GkLKf6MH3zarw+UQ61dn1S2Dp/ShBX22sH496kCVTjQKleuvtN0oNwM3U0z1yQ
 qE7NysJ3Ta2HIA8Kh7rU8lW546b7pkq8wyfwGFxVHUpKgtDs7h3UWC1WxJr5d5QXdBDTZLZ1c8Q3nRB3zxAAEABUWF//LD9p5A02cp/qgibeWyIocHXKSTJA
 8yfsOZkXbPmBX0fon5F9pETaMZsjRyvrF4ISpMR0GjocZdQL9SZXuY88AyhURQxuP90DIgdZAx/WGP4x/Na+VgsS9cKCKFlnSgfh9sdIehTyYS2FjHaD9Kyj
 36feUfyFiFysgR5/EW5i1AIl747Io7CKsCEUxjbKUxR8EcREreVi9nfqwsrzaJD7dQzNtXMKjEXtT/W8bwAOjF46xIL3fSc/lVtTDoONi2rKnrYm/p1/xbD9
 HC1ncz8cXxMRKWsA7G1mKkOS
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265455550245?=
X-GMAIL-MSGID: =?utf-8?q?1592153265455550245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Just a trivial tyop fix.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b6cacc4cccf2..31142b72f1b9 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -217,7 +217,7 @@ void hv_synic_free(void)
 }
 
 /*
- * hv_synic_init - Initialize the Synthethic Interrupt Controller.
+ * hv_synic_init - Initialize the Synthetic Interrupt Controller.
  *
  * If it is already initialized by another entity (ie x2v shim), we need to
  * retrieve the initialized message and event pages.  Otherwise, we create and
-- 
2.15.1
