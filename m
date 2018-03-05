Return-Path: <michael@ozlabs.org>
X-Google-Smtp-Source: AG47ELu0+AT4hGi7YgAM1JTpWO0B6h/lYRK8nTVCX4OgrfY37CpPnFP66derykyKCNVny6gON1bd
ARC-Seal: i=1; a=rsa-sha256; t=1520253373; cv=none;
        d=google.com; s=arc-20160816;
        b=q+Vf+g4zN4yh2tRku6lvT6u8nrkI1auIKdLlHTGxwupnmtwLuWoGWZLKsop1zRbASt
         WdbLfq64lNPxLjQFb0LPLITADURKhnwGDYJIGlMc7uQO71EIxo8sSlTBEPcByBgbu3yh
         FaKvOEACm1p2YY9MWPu2I4ccf0+huT2t3YPdQWCXd5/3hUhFL8QXwr3oJR/rwiyG+ONE
         kUKhN3Hb6TDQ4WsDFkci4wtYahWT10WnKHKDa3ytDisXP8MkufGHfpn5iysprmLpdL7+
         BMRachjPva49c4hjn1luqwJ8fxt7vwC7aNagxEN/KuD3DxzN/eMgKTBmVl/GZPrbqJlB
         lAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:subject:cc:from:to:in-reply-to
         :arc-authentication-results;
        bh=dL7VDeyw3KqHaUe6hzMnEtg6XKc9AdiBNe7PphKWqfI=;
        b=0UCr8W4Df5Ihr0OnWrgB2xJn1IhDqDwpo6gqnE+fn9l31MFJ2brvYl9AvEb2oY7mNx
         JISfARY5UVD0f5pQ6KZKNXEMxVHgQK0Uq2iyb7MVMfkz6MpULpobephm86/a/g5WMXoH
         BEo02+39oWeF0AfbMAqFs9HY39iEPWt9OoJElnsaHhm/u1C4BHowjm3KPMgwAwnlhNdI
         y2MQEL7211TCqMdv1s6RJq5CPNN9uCuzAMw0LVaaJL3PptxuVLruZofoHZBB/ZxWF7k0
         +qToDmhdlIJWaffnZOBe54CUF9/Lfu3RTvX9O6SJ/NDzVzum/FL+gSPjag/+aSbCEqpj
         EgvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 103.22.144.67 as permitted sender) smtp.mailfrom=michael@ozlabs.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 103.22.144.67 as permitted sender) smtp.mailfrom=michael@ozlabs.org
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 07c5ccd70ad702e561fcda8e4df494f098a42742
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alastair@au1.ibm.com, arnd@arndb.de, frederic.barrat@fr.ibm.com, gregkh@linuxfoundation.org, andrew.donnellan@au1.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [v3, 1/2] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
Message-Id: <3zvzsh56JRz9sZd@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:08 +1100 (AEDT)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1594101201829777523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-22 at 04:17:38 UTC, "Alastair D'Silva" wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/07c5ccd70ad702e561fcda8e4df494

cheers
