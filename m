Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519055452; cv=none;
        d=google.com; s=arc-20160816;
        b=ytG6NnNfM84bSPO589+1iiPtFkx0lb6FzoQoT23HNnquHWgFHNQ3NGsiYG/0imCToT
         xagbRykCEMtIhikJT94tS/d4/9DmRrTwWnDrzd3GF5lALMSw8z8gFpSf+ZhAGYzc3ESr
         jGJwXA/ku0Uwt4OZrdJjeqM535biWyi7wjTRmd+oIV3Yqaa4SAE7P3MRMIWrP4gEilMB
         eymHU92+SjMbQR38W0Il24OZUyXvWECIf9gA/A5Ht68O/Q0IoBuG/FmwFhVq0Up/PqlN
         8oApLDvqBOIsj8uuQsBVf03YK6GyNzv4mDS5a/95l4BlPZHrFgt7mWcQTU1Gaap5CCso
         ldfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SxZz6YQHDE/r3kUK1oTBZimPD7uGwxGTozNDFf2aSXg=;
        b=S7xzdzMyaur8oxFKFzI9tjrPlPgLtl8KvteJyboypordj6ew2/nm221GpnZ+Liw7Nw
         zoyYIBFRx05AoJ5Vd0sHcCZvo9MncFaudZ4rqj4WTdBmhNTMAcIzDRq/rNuXK66t6IN2
         C0zenU2PReNpQBx40cGddzM4izyw1qvo8r8UbFmHec7JL/0DHaBpLmQf2Z7Puu/C4vXu
         vVsMIJleMPgxRpg8u0XyuKZ5AQ8iAxsX3Vyo6V6+pxvi5wypzMETvNIUuqotHtW8bTKY
         DiXbZMOtP+n8vPGbwlUbl/YuPd2yfs+/LkkH5SLc0YRK8bqgZLC7hu91PvuTURfzhHog
         Z+0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x22491s9AdXUfe+bMNzLqisyHQsJwaWw0bV8xerY+2J8m0deVgvqDdKbrXs5GF4EYxRoLPbdtCQ==
Date: Mon, 19 Feb 2018 09:50:50 -0600
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core
 binding
Message-ID: <20180219155050.66n6db3pdo3vub4p@rob-hp-laptop>
References: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
 <1518709601-17232-3-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518709601-17232-3-git-send-email-amelie.delaunay@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592482455277475921?=
X-GMAIL-MSGID: =?utf-8?q?1592845090065019562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:46:40PM +0100, Amelie Delaunay wrote:
> This patch fixes binding documentation for DWC2 controller in HS mode
> found on STMicroelectronics STM32F7 SoC.
> The v2 former patch [1] had been acked by Rob Herring, but v1 was merged.
> 
> [1] https://patchwork.kernel.org/patch/9925575/
> 
> Fixes: 000777dadc7e ("dt-bindings: usb: Document the STM32F7xx DWC2 ...")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
