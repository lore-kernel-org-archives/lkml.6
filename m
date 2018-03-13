Return-Path: <rohitkr@codeaurora.org>
X-Google-Smtp-Source: AG47ELtr+BSYJ89UoTV730T0+vRsavLfq3CtbXEjWmfIpesaKAYsOS0vS6b6LMiSWOcUrF9Ps1nf
ARC-Seal: i=1; a=rsa-sha256; t=1520941603; cv=none;
        d=google.com; s=arc-20160816;
        b=B5gTet+TmRHnVt3HZznnqGuVwR4wD9srMaxT57gxlQ2E/A3V0fEWBw8rOWIUf1czqL
         VBpe3ogbXvJhr/D9XJzCi3ney08oKp5XjFZA/EB0we/aP4191WAaUIV8RElSqEmixQIp
         KclSFvY9c6uSnyZUgXzrcOmzSKvQlRvVuFcIUGaHo8xZGGx+BqEHiwVA203HfNPiasTJ
         RL3r6dG51Wn4k8r8KJd0fUIoTlqgGvV0vFiQWlw4Yj65JX5/0Id9HvtlQHZ3c4Clry13
         k+UlcqMCiUbFXX9dVYEeRoLIGtV9anAFp188fRlbpG2/Tyh3arnrf8X1h1gO0doZOqaX
         mlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=zgFAQyvqVT3tCNOY3Ec0C6YIYv3GK+dGOeJV/XVHwQc=;
        b=h2Ze98W+FUIHyzC5LILJPSseVkDhhUgplLj/t8fVjqnHFAZi+CKkp76NNmnBHvD53E
         914yCJhx7h9WYdkjVOFkhG7IIV7skLkkaKcOQRXZaMKtvqTVqbzr75T3E7YkHc9/K+q7
         QtgEb534lTWRTzSCDSl/lzuisok9sTld8SN7bg3HI5J59BRs/Xl3jxq71fxKJWRfJ0n0
         5/RituJWWL3QwLsH81Mgb/iXqpIP1IJN/Qki28Nas86Pyl7ceRMCHREsD8JvMskBJWcP
         Y/HwDHaK4AMEXtSBauQZ6SO4ij9OKyQXdMrX6p3jjpuVJmJZ5XUydZ1KdDkBHGRx2RDw
         a6Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cD+MqGls;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LQC5wGcR;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cD+MqGls;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LQC5wGcR;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E56060218
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 15/24] ASoC: qdsp6: q6core: Add q6core
 driver
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
 gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com,
 tiwai@suse.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
Date: Tue, 13 Mar 2018 17:16:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515922191950788?=
X-GMAIL-MSGID: =?utf-8?q?1594822863140531229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[..]
> +static int q6core_get_svc_versions(struct q6core *core)
> +{
> +	struct apr_device *adev = core->adev;
> +	struct apr_hdr hdr = {0};
> +	int rc;
> +
> +	core->get_version_supported = true;

core->get_version_supported should be set to true only after we get proper response from adsp in callback(). In case,we get wrong response from adsp, memory for g_core->svc_version
  will not get allocated and there will be NULL pointer dereference in  q6core_get_svc_api_info() in below statement
+	} else if (g_core->get_version_supported) {
+		for (i = 0; i < g_core->svc_version->num_services; i++) {
  

> +	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
> +	hdr.pkt_size = APR_HDR_SIZE;
> +	hdr.opcode = AVCS_GET_VERSIONS;
> +
> +	rc = apr_send_pkt(adev, &hdr);
> +	if (rc < 0)
> +		return rc;
> +
