Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518446216; cv=none;
        d=google.com; s=arc-20160816;
        b=SsL6kK8HbZ6TUbp9QjSEgsurGHK/dY8KSVwttj6JbRKbDcY/xNa5b3Tbrl5VRDfUng
         QS+0zokx4AH9Vm4LdHGVMJD0RWsxk8DXyLxmHdg2eB+yV941nrp3fVa6y7rkZxgMA/p2
         zf45lNQOcnSgVjxWrK7sgVUv1OahAuUkYbUyRTEBSKw/excYz2+Q5vdDMu1/YT/ADYaH
         QROwa4jwUQ+e7c96+laZM/IOgmHl1OZOmXqHtl7BhuQVRo6kewwqd6hO052wfAjyGxLy
         DvZY0MuJYMDJ3Zn81gclW4GEDsu/k+Kfmbga3cYpVhtifybYxPgiwqCOAkDLG+ombsB5
         wZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7IQf7xgFfdtb8mDAyiJnai622O5YExOWlzj9lXI0wcs=;
        b=aCwOWMnbIzy+MI6l5HgJv4DoEOcljMAXs0Vlyazy5NEY3+Rpnr+YGWU/AZInNpGlzQ
         /1lXG0VOVJpKSgjdTCh/+oLtAnXUKGmw2Xehi/mzfMG8B1W044fJnd0RLzPU3xWm+KGX
         tiBnfL263FVmyev092DhhxsAbGgneUNXzt4prUZ9lNGh2dW3/usHa42QUPA+9xnf81p+
         reHkRRMK08ugR7gUElrViOWQ1W+S4XZ2N1ZhIb+07RxEAr8LA5CwxRez6ZQooS6+eguy
         RgF63YOZDvJlnL+1cIu/Wn8mFnBTrsPaH6N6ObH7AAQUXtZlDLt/cWkBIG8knezrTXmE
         0AxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x224bi6k9YRW5E5OKRIJgbunKwMd1+vWwY0D21cjCLQ0EeujzSjj9KrfvU1UzPe0vbuCohhxyRA==
Date: Mon, 12 Feb 2018 08:36:54 -0600
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: fsi: Add optional property
 no-scan-on-init
Message-ID: <20180212143654.xh3vrhvvj62mdtog@rob-hp-laptop>
References: <20180212051549.8575-1-joel@jms.id.au>
 <20180212051549.8575-10-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212051549.8575-10-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171060192825925?=
X-GMAIL-MSGID: =?utf-8?q?1592206259453693770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 03:45:48PM +1030, Joel Stanley wrote:
> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> 
> Add an optional FSI master property 'no-scan-on-init.  This
> can be specified to indicate that a master should not be
> automatically scanned at init time.  This is required in cases
> where a scan could interfere with another FSI master on the same
> bus.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Please add acks/reviews when posting new versions.

Rob
