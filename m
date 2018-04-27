Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838236; cv=none;
        d=google.com; s=arc-20160816;
        b=NYbyDf0E1n8Fb4O6UbaxxQq7VwPCvM6BOjbumzbFcBH3SR3AmAfNvPtmqcByR+zsyt
         OM0TZapzceKfDg9v3zFFEvNNxbdQE5b2iTT3OO5sKAQWDDAgDB7LYDR9xDLRZsKH/hJc
         RlArh5ZHnliSAR5vR+HcyARvcilnWN+5b24EipNyqj38fSXzODd6vqgkJVdtquV74tYy
         5hG9sER9aYVgaFh9xZFo6qweCdqy92WAr18X4jssM94pc+2gRS3zurgGUM8W141W1Ei5
         i+0ff38VhYjrykkAVNh9ew2mFfpcnBUmT33nb9Rc6tSbDHXQuqVnXU+zN0Flk0dLKZjJ
         j4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Nc42OmmObRbFP6u3Q4siHCxT8wxoUfx0y8jczzah0+8=;
        b=MWw9bjrA2wle0EFBNRMJrOlgZYBMjTG+gq2TGigOF8g3jKpxte4Brfmk32dQqmKjr8
         C2XumeZNShq63AMjD5K+sZO5/qOt9s1LIIRdj1h2aLip4uP3P8gra0eByZwczSk2l5/G
         qaQRGG4ytXclBqjiczV+F347Or/J0PqYMmtshSdBnA4Em7htWBAxC+DbWvbtBPmwp2Gz
         c5vjFBXujH2YqaivBURfPSgL+6QOH8xwBV3ZVM85nT4QfOFQpDDlgKRQAUAy8dFmUdeh
         hDe8yRdZdyhFvXi1d0/FRii0p7FJvVrxGGT6UfXNqVHVRMBklyiXS3//+R9nFdY0PFMY
         sQfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZqFRnBJkowGb6nosM5CdfxEpyo6Yz3NIwBtoG0EeKp+Uz6H+cUPW2y0MUwmCm2342QX/iIARw==
Date: Fri, 27 Apr 2018 09:10:34 -0500
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
Subject: Re: [PATCH v6 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
Message-ID: <20180427141034.qsk5o2erd5x6cm2f@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801758328613350?=
X-GMAIL-MSGID: =?utf-8?q?1598908778844279835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:45AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for Q6CORE DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

Reviewed-by: Rob Herring <robh@kernel.org>
