Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520428410; cv=none;
        d=google.com; s=arc-20160816;
        b=ZIy5AfDJerqufFYO7RJea/VeOIPpCmk1UrUNKIBdo9AxcTKTIQz9Ed9E3ESmG9cTOt
         weXKUmuAKm4MXCnOkMqRQ1RzhkvLWQNmiuko+7kSNX9+1ppbSFBTLAsOCYMYhOEDDpgB
         l1yJ3+YWKG3FrTmAPK+LDxBM+GV5TJTYfuM1W3A/sUVYwP0ePBNKZoFzMhCXDRgIVaq/
         229k8zOLVArZiGjrdcnrYErrlbDXYad/GWHGqfKmBl1XTFE4YThf2GxW3Ms5drUWs8gj
         irKdwu+WLC6oMYZtZfGW6fo7Hc+mwxz5CSpfWnxFL0jL7M1eOKiXoUL63tPE5UbA9VcX
         Sm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=gTUOd17ZwDdn2T1UrBZYDQ2Y4gS7ifY5uNwWuNTknMA=;
        b=aRU3MJW/2Z8QsPAma3NF3B7f3VoYxLIgnWN9Cbvwh28k+rd2BCv18sTVTfvcdCQuoM
         DaCcNrJdB84L2S77vSb+AGf4t4+150BgqdMnzR/qpAB3l5g8UvG2W2aiZ/8wxmhYL4Fj
         JCWAusjz4JKmc7RXcrAEQldNyKvkIf+Blom0tfdH4OgBo0M0YdI8wbJukGH/D4xcuYRc
         QOtjgu6/PMzaVBM7N8SEjeNyCQ9ZUGFFJJksA9fTy93ppIZ1zmf7Qrg9saKFG3INWSr4
         KEU8XuaLikxQ3b7ROTHj+5p6ch7Epj88AscEhnav9t8lQH45XMM40s4qk2jPl9Tbie8d
         TeIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ef3H42dF;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ef3H42dF;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsytAPzT7TFnjH+7uDD7fQU1B6ig5nI/Z6qHbb/lnqFmiRdy+UhaEFlK6LZI6C79ri/aCNWxw==
Date: Wed, 7 Mar 2018 13:13:27 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Lei YU <mine260309@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Document LPC Host
 Interface Controller
Message-ID: <20180307131327.u2tvgabim62zeb6a@dell>
References: <20180219072422.22733-1-joel@jms.id.au>
 <20180219072422.22733-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180219072422.22733-2-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813249308453980?=
X-GMAIL-MSGID: =?utf-8?q?1594284741100777071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Feb 2018, Joel Stanley wrote:

> The LPC Host Interface Controller is part of a BMC SoC that is used for
> communication with the host.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Move the content to below the Host Node Children heading
>  - Add Rob's review tag
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt         | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
