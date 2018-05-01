Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525178239; cv=none;
        d=google.com; s=arc-20160816;
        b=oV7alvU8Lfo0JCNG505HV+zUbY0swcFhTc1NnhVSbH3b8DhQVwLwC0+V3pyPT0eKTL
         3DfGJGpopMfJAsRc85miihzte5bSuC7pK0uxwylReWQDrRCa7JyzWqmtFsltN9RoPRU4
         jpfTTDXwcpNL2DxsNj5c0Can+EDL7jlFApTM5CRKL3HsPNysqKdvO8hQIkJ5d2Iqv+V4
         jCiypEwaHTTSWQJwQ5NidrZ/25BqOo29yh6r8EP5UfpVB6W505IXhrPmhf6KoN9g5W8w
         Rk8aHEc8BImjY8FU4Cesxef0ZdfZAOYgFKEApuMnUS9iQgE9KK5LCM+9RN9hlKHWZp2t
         eX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ewEijWt3WMYxFI8Tl0uHrtXVspJJoahOK54W3ecT2eQ=;
        b=daNc2p+EqFXwr3bqHPKEyzsP548M4G/ISDEOZR9aZ1nRhNBwgyakZpjXqKrQMKFaP3
         fvkrBLEwC/mB1fEsUhF8XtOolwfJJUWIitHWGFIf3wQ2ZMg6d0tAbjP+9RWDWAe/w0g7
         CweJFOYp4wxtX8HlOo0HYwgTZGztSPut3GE2YOEz1IaC/GZKU1l2op2CJxtZRigar6Y9
         TL/T4KVsyQp1UHaBZGhaR4Bt7cWHOMQ8fwHWlN1fuWtIZLolrE0wmkKf6oqB+sWfyeJy
         2ihZYzPvfLTnMUrT2nvh9KqmAmBaUetuqf99bPxGfBg/pqFyTo/pWt2Ku3yfX/Pw1kFS
         DFig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZqa1TqVlZzmdoHMFvQv47pgzgd1jfJ7xHn9kSkjIJ7MJT6LlZgghasdnk7m+VmKl3aqtIrA+A==
Date: Tue, 1 May 2018 07:37:18 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v7 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Message-ID: <20180501123718.GA25915@rob-hp-laptop>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263610947296611?=
X-GMAIL-MSGID: =?utf-8?q?1599265297783545208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 01:08:00PM +0100, Srinivas Kandagatla wrote:
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

Reviewed-by: Rob Herring <robh@kernel.org>
