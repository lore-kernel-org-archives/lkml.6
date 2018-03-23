Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELuSJmfRjG2dNosv09ZScjcz6H4hN2/MRAiCcB9ZO2G8glUDqooH/TX9fZPevPxyE6HGMJbf
ARC-Seal: i=1; a=rsa-sha256; t=1521820940; cv=none;
        d=google.com; s=arc-20160816;
        b=Djo5pbn7A6oxp2hNXJwsl/iU0vRazu1gSbaxlMLHtbMOHGjSv724Y0yHxU+7fwvocd
         wIfI5oxvAI9GGby0dH78+au88hwwmONiDZ7wPSKdVZURen64QcTnJNNN98oPmXayPImo
         tvm5Ea8qc1ZhfvK45zMin8QJBkPddRaUsifsFW/e/sSV0EWdJbxKrrC84QcaFyQdIjgT
         20WqOL50Pa+dvi3jBtBrIXADViqCPVyuPpiVbJ9GtjLzrCKl52udVouNVI4i7V2GEpdB
         AwOluiyFVESwhekzsj3BCFtJicp7FlGaOiLxINwouTX10KEBiwTyw6wRl9PeEH5cS6hi
         n2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=FUfU/voDJ9KBhK/IrPhXQqHkaYzzO7Z5BTVccYVYS/4=;
        b=Ga4O6LwAxFVFdDGk6/VjO8WdhWh+23SekF0CU7+umz8DYJMKtdRrp23IqVCKn5tM4F
         /SVUr2ob5b0LG7muLpxCb1Zbn0l98YpQ+yWxNS5VW6T+ayOUT84SdqSGmbngntYwCBQB
         imDpaxwVmC/xmpAnXeBczLITONCwEiRtYVhqu8xRRfJT5rU3LKxBJfhiWcV3F/8kTbss
         sbMsru2K+pgzSZAn24Z6PZT2fvf589TidmEy/Wb2PVUBH3bIs4bdH+dWjd/TDBdLQMOW
         Ifqhs39DE16kKnpfT3iEZRIbBgjPu4fK/U9koSahcAEq1pQEzEr18o+zwJtUU8n9LUSq
         wV2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Sat, 24 Mar 2018 00:02:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vitaly Andrianov <vitalya@ti.com>
Cc: mpm@selenic.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	robh+dt@kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, t-kristo@ti.com, m-karicheri2@ti.com
Subject: Re: [PATCH v2 0/2] Keystone2 HW random generator
Message-ID: <20180323160205.GD2186@gondor.apana.org.au>
References: <1520962411-18208-1-git-send-email-vitalya@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520962411-18208-1-git-send-email-vitalya@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594844768121976594?=
X-GMAIL-MSGID: =?utf-8?q?1595744915080791937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 01:33:29PM -0400, Vitaly Andrianov wrote:
> Keyston2 Security Accelerator has a hardware random generator sub-module.
> This series adds the driver for the sub-module.
> 
> Changes in v2:
> - Changed subject prefix in 1/2 patch
> - renamed dts node 
> 
> Vitaly Andrianov (2):
>   dt-bindings: rng: add bindings doc for Keystone SA HWRNG driver
>   hw_random: keystone2: add hw_random driver
> 
>  .../devicetree/bindings/rng/ks-sa-rng.txt          |  21 ++
>  drivers/char/hw_random/Kconfig                     |   7 +
>  drivers/char/hw_random/Makefile                    |   1 +
>  drivers/char/hw_random/ks-sa-rng.c                 | 257 +++++++++++++++++++++
>  4 files changed, 286 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt
>  create mode 100644 drivers/char/hw_random/ks-sa-rng.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
