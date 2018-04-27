Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838060; cv=none;
        d=google.com; s=arc-20160816;
        b=chiWiIwTr9dg6lmLhlqVjL1TGoqlS/9VkZU8JNhs0vKA9HHh3JOfHXu5i6XEIJnVfc
         ORd7y7I33jBu/B2oesvaQn/UZZ99YdV4Q2W9KIjiYEEh7z84VmQcZeeOV5AazddYCaRd
         EujHkeEuRTy7H20nOXQrp6iszHiA89uW4+a6Hx7YYE/IQeAalNzbwTbWR2mQoLjZMOjc
         fnZSuMPc7p6DvNRNiAYVKGdOKGCzVnvHfkzgpbKe+8tDdqx1vyxj0C/wzzzXWjJiXYUb
         JDNTiKkK9Uv5J55LMznDO9okzq4Pwyfg9AERGSjWmOEQzT3QptmgpcOs1nN6caCue/vo
         R8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kY4ZE/3Mt6lnVuc0HJHAple4NEFX3HSreWbkWHVBofM=;
        b=bZtGhUkWJvynJTyNq1VLrBRr8sjCkQuWQg0o35O5RBl7pxO6hetqH+rGugKI8OzpyI
         izvRHCOmgyjeI8DZOCIbBNxiZvMMAr4wfBNcZXlIJzR36NIaGNRG2Bi949TkeJgAzJ/S
         peDyv54huJY5+voDeUa8Sl+lXKDmkdaegfT2djKNFldF60Qr+jcWoTzxQwwIrgxX0IUr
         MS4biZuP3wgJpMKUPDwphNar/hoQpht+i5nsW5IaQwJdwofm6FOipDx3QbNMwGslmIO2
         glDC7yy/dPvRfU7sl0hMvoLcM0UBFqcLrMtzkNGC8ef5IIcl8X4sAzbiIQIoNnPYNt3D
         CqlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZrMtnWkkXtME9Y0ZLtae2zvxGpgSxNjrwhC6UvrtaOwKcDmRKVw1dIUSGfJc2/i7CL9eY1auw==
Date: Fri, 27 Apr 2018 09:07:38 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 01/24] soc: qcom dt-bindings: Add APR bus bindings
Message-ID: <20180427140738.lpoi7ow7bgzjrumf@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801755012499070?=
X-GMAIL-MSGID: =?utf-8?q?1598908594080263704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:43AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h

Reviewed-by: Rob Herring <robh@kernel.org>
