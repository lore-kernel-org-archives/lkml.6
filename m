Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/GEVBZ5R3rbexwD5sWCKCb4cdnwHDst7RHQPATkk31OXQ62KdUqo4SJnYvJJnFPfwHa29n
ARC-Seal: i=1; a=rsa-sha256; t=1522297664; cv=none;
        d=google.com; s=arc-20160816;
        b=Si8m0wYEFd9pAd/UBa9gv8VgcxPsGDPxmUmdRBmhu9BD5ca6SZIN8L40BKLCht0Gly
         1vO04k7v35WcvupUUdB5xJxjApWViwCNO3viFi0LPasf5YAIOlZuTXIsP4AnaqplvWL2
         wFyVzInKKnOxrbHRxcZVyjXQEAdgcTQVdTzvzZdAIPuyknv9XcBvM3+nTnkjAEZrFy5V
         YCHAVsqpUR4Ug4Z95FlYwuC5Y4t0O11balc4LELZuziG44y/bLGcui3KQJf2xTiH8ww1
         LZLZ2xspZMwD0cOqjRcBnV0FufgGntVADL/DhmhIGO+xUq9fV72MjA4TuaPAFfA+u0gz
         ckjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=OZVWPAOt+PxsQkrWCsk8qK4Lrxwh/4f3HEJtw8aoKlY=;
        b=pc2+PR7twhQNduc2M454rSUElyEChk/mDhRCm6RchtZFYwySqSCR7TzQG6wCENAEVv
         +/hleDbFpDYEe8hmpTTUjXjLqAGICR7mNzy/s7oRk0BMTKxS67J2Drs9rTGEbT5iGMpE
         JNYL0zFh1QnY0alzE8U+lfcP3PTZCZt3LDg8UjdajToFWTd/hCSixFzGTv18+YPAb0P9
         3p19cvL2pQIuu3ff2pMqpNgpYEMeQCWgFqOXg21Q2Ld0+AeGFIYc4+5JQNeU7ftyOvxJ
         vUJs7X19OJRNKCzYyvVFzFkSAFKsmW2Lzce76V/BDa+DZCyrTe9ATygkH1jUQgVh19tn
         qVmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 05/17] staging: lustre: remove unneeded include.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760838.27689.7863544405084944270.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244795912178480?=
X-GMAIL-MSGID: =?utf-8?q?1596244795912178480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cfs_hash usage was removed from cl_object.c
some time ago, so remove the #include as well.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/obdclass/cl_object.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/cl_object.c b/drivers/staging/lustre/lustre/obdclass/cl_object.c
index 7809f6ae1809..f1641645acae 100644
--- a/drivers/staging/lustre/lustre/obdclass/cl_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/cl_object.c
@@ -53,7 +53,6 @@
 #include <obd_support.h>
 #include <lustre_fid.h>
 #include <linux/list.h>
-#include <linux/libcfs/libcfs_hash.h>	/* for cfs_hash stuff */
 #include <cl_object.h>
 #include <lu_object.h>
 #include "cl_internal.h"
