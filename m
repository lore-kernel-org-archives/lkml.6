Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AB8JxZpYvaUqicRtgJ93GiWsIeH3SCeWR+GtYnrTnhzCAKg4vF0kA6E2zCyUU96853B9jhImYPHu
ARC-Seal: i=1; a=rsa-sha256; t=1525893427; cv=none;
        d=google.com; s=arc-20160816;
        b=qpOKiM/Ff5r7BOeoYo3H8hvNiXyRts2G/eXtTDLUenYQLE099vBlrYm1Ex0gT8PXDU
         Vz2mad7tSCRZ5BvoTVLYQMBqqezWO81QzN9s+imWcX2oCUTreQKsmNSnOjq8WUPANJDA
         x1SSaR+NtHZokBjFp03Pys2ab8cyb06elURA5A+FbLLiPFQ1UgBA4VXhY40kxkiBYQj6
         dazBA8e7dMxiEl3skzm+iCHLDy3aiyBWM0NbOVouBYfXaj4gYuQpxWh6V3iSk+Cs8K/G
         w8qmLjrDrA+eYLkSI6e8k2pLSngmf65Om0Su/bNJPEEZEjCGfcqR1jFR/auWelMtZBpM
         PRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=XB7Xw9RvXG/eENKYqyrfKON9sOURAbG5DIEXsqCKyfc=;
        b=IgvATmbE9d4XzkAPqsnyyRLlVs1P3LpWAzy2WVANYbYL4knR6sS0jHdCvX7UNAuJgG
         2oG8mdnDTqpXgPKPEG0OWc9tcHdS4iYlbFKiz6wD1WvEnViwGm4p9nJweZH8ZVGfN4xZ
         DfpS9TSXnpGJtiWo4AuRIAA3VomFwJF9jNpo984ySFvIMm6WG7JhZOh6PwWRl9gxa7Bh
         v1FZ8jmmc00wH5COVfCCm1YcDXY9BOkH3Gl/9g2UHfNYodr6cpM+hIyXDil+lAY6RgJQ
         DG4/+8JtErndU4eBYf1W29eyfsu2Xr5sEksNPKKZaFEPqfunsTtnAq8xsChrM+i7J+ka
         tAJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Thu, 10 May 2018 05:16:57 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
cc: peterhuewe@gmx.de, tweek@google.com, jarkko.sakkinen@linux.intel.com,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        javierm@redhat.com, sonnyrao@chromium.org,
        enric.balletbo@collabora.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: replace kmalloc() + memcpy() with kmemdup()
In-Reply-To: <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
Message-ID: <alpine.LRH.2.21.1805100516480.12749@namei.org>
References: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>        <CGME20180509001300epcas2p3971900d48408aef6a80f59b9480aac16@epcas2p3.samsung.com> <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1600015226290828171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018, Ji-Hun Kim wrote:

> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
