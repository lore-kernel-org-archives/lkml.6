Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522162371; cv=none;
        d=google.com; s=arc-20160816;
        b=q+Iadjxe0M8VB19RZ1QWsoP2hgPE0vGeP17rowly8mYS45xiYNQL4uwKcmX3bUXWqO
         elbSU+RGsubQA1QMTmqKWaS88bv2Q6TXMH3qe/EnaD0shYyOOnpr32QISMOechC0KjzW
         qTpNmCgtgnX6RnlvZ7CAbgYDYICUlK1yBqC92dcG8pHRuYbDv+CR/ewF8JhlIPUUNXPt
         bGun2GG0V3G5B/AOfy2KM8UUnWC++1ylJKvXjCoEgMSeR2ZFA8Zjx513ZBGsGy5R4BV6
         aosYBEjiMIJssazxuGtG6WKuCKVljnKUUc33i9L1hXSRYPaaZAJgJtsYK4rMvgbxHOD3
         wOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=MvCUdYMCUMLyxyx27J2u3nysWk/jkimERk+joPCCbgg=;
        b=EDRirq/Kxv0+mEfk4DimTOuL+mMMAhSBs0JWW/dMp4XDRATG5K7aj4xwg6LThLNRxa
         CEFcDS2b6abih2hXiDJa04VhULPBg8TIm1kvwO7cFQwHzRjty5sGNepbeEX36g4y4uI/
         1jZeGJAlckA6iDLt+y9e1UR+HLOAL8aavRvsVoeWwPHpMu78PKva3JP/2pj5JdpahbtR
         6ApkEmeyimBRL//4cdwEo7ckmVhXqLKRV8pK109bIkLnNa9vtPKYTEUr/9LqTXV8295i
         0AP4CH5eO5GH611dYMrqYAeOvfQYmVwdgfVnw7PMCeZpQAH2fXzelQbTBPEeNg2Su4z0
         9yyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx499caeifTRyRf+SC4enccMfVCA2Ur4F9wVApMDqhplWaE3k8OjFRFtXaBIPiIGPO8hWjGWKOQ==
Date: Tue, 27 Mar 2018 09:52:49 -0500
From: Rob Herring <robh@kernel.org>
To: Rajkumar Rampelli <rrajk@nvidia.com>
Cc: mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com,
	arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org,
	xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de,
	krzk@kernel.org, ard.biesheuvel@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
Message-ID: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1596102930652806271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
> Supply Device tree binding documentation for the NVIDIA
> Tegra186 SoC's Tachometer Controller
> 
> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> ---
> 
> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>     Renamed dt property values of clock-names and reset-names to "tachometer"
>     from "tach"

Read my prior comments on v1.

Rob
