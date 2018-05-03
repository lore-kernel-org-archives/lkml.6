Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqAI9JS5WAE8Rt7jqzatJ556vqd9NwGA+hz0ASDmNX/YsCDti57GOJ9dqE7DJo6oLk9iYiN
ARC-Seal: i=1; a=rsa-sha256; t=1525391627; cv=none;
        d=google.com; s=arc-20160816;
        b=LvhyqKP/CHrO2GN7F+X89Di3RcCcBzS91bUvMYgvxqgFFRtXAp+PokH8Ly5tctoufR
         26Arho2Ix1FRRhb1Aw72ORJ4U+ZpRXaQ3HZFdisPFme03SpVqXnsYPOQxqkJ/pP4vzPu
         M7nmNEpADKTguZ+fqfUblyA8BaKgw3+UoqP+8i45IFwkMn8vhk3pXXOQd7Fw9PRBllDr
         LO0b+DGDbw9V5cV34DtScAnViVNEvSMhQcs8YBE5gM1R9j6OjX2M7LvdRhYWbfts0F2N
         G/VFsDeQnJkLTeDsNHeYitutcT2gyc3AwlXCFjEVOE75fP1/e8qQB9eBsqONiJGXoPAg
         a1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=1PV5N/FzyRDQFo43bJgx8382SEzW2DAAeI+oN9Wrzlg=;
        b=eRpu8xDc039oNgx5IYuI+spWuI5sLoTCNmydH4CkEH58U9IuvVJlB9WfPZhorNG/we
         l+RgOL+7LqI4pDGppGq02C3+RU5zYvcAMO2rcSwpVvIYIvldKfnZZhqI8pHXr218qJib
         kHWV+gLV6/igyULnNq5EZ0sIdXGoiKugotGvI8DH+ZgBOVP+BzHC0dLSKLN7+1os+GeB
         122pdk1cZcF3rNOpnCuhJUEsVuw1jN9qKA9BJEUq4qf9ZLTndXAcL/KJOWbDGO97+owr
         +oOt79odv3aMavjRgLP9JFc+sWtBVJnmhKksV1PXWKwMtYrcXkjunCxBx4UYrYnnF6Sj
         M/xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pKZ+tsh1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BIGtVHrF;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=pKZ+tsh1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BIGtVHrF;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C6DC60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-6-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <dea3ab89-bc4e-a6eb-f2ee-452a7a34cceb@codeaurora.org>
Date: Thu, 3 May 2018 16:53:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263612223089566?=
X-GMAIL-MSGID: =?utf-8?q?1599489051376245344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> new file mode 100644
> index 000000000000..cb709e5dbc44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Device Manager (Q6ADM) binding
> +
> +Q6ADM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
Correct "coommon" to "common". Otherwise looks good.
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
