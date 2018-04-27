Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838459; cv=none;
        d=google.com; s=arc-20160816;
        b=iAMFAPMhLCcn3zUbZUCtRKkzXEc18SurGaCbibRw6twaCeCcH7nKoFYCr4mbmlb2S2
         ZAQte8dVMM2G5+cN5odk3fuq/4dP7hkp5NUVrH6RDFGHyMKfpzXLQF971clHVxipGof2
         XHU0oq7E2nIDIA5b6qT3QoBYkpHYyeRy7N5kd6ZxFe3hWPcovNDD1aSX+oqNPmxVPEOG
         8y0c770ByCLkvZ+yyFESLE1zlFkNX9EnpMtUFWYWJTT3sI7QSJl/XnnpkzBx5b4PyxxY
         wrdH/z9nZ120DUgw/E4HR+N9nvg8c7xkmXQASEXxKziwdUgJFIkZz1dyCcZF2g8sT/I7
         KY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BKnNjY4wpDEWiATaH3o3X+oYdRudoe0NcHl3LamjsOQ=;
        b=DUIvh0lJOIXQEmvlup9kqiaumSY65wZmWQZbcAYcfwei/diuSYoQEjm4kZgnRLLS5P
         Kie0nRfaRmnYak6C1L/uVcR2HHKIBnqBFHUbDjxuFPdpCP96hkR7GFkosJNRdHs2H42Y
         Hac29SjAelE1j9jtRljakrgRxQhtY1NuZq6dGcJ6n/oycjaW9ly8AfgAL6wT8spYshjI
         dSZItasxgsMKattPFGr9aePdymlTKpQ3d1Jgd6yTeO7+5GebKvROw9Kmwa1OJEjEVynP
         5hLiTHL3uVthxSllgnLWhTcfBJz7X850qm+wOvRUqqQ/X9UyUmvL+TtnBCgxutXCiE0L
         6c+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZoqS875NKvfXhZIZbGtt4hIdUDQpLydGMuPyKqJP7G5tA8WZdLyqoE2Vc1UP1l6B6MH7VrphQ==
Date: Fri, 27 Apr 2018 09:14:18 -0500
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
Subject: Re: [PATCH v6 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Message-ID: <20180427141418.muryvgoyedcdltab@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-6-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801760840380734?=
X-GMAIL-MSGID: =?utf-8?q?1598909012882566575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:47AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

Reviewed-by: Rob Herring <robh@kernel.org>
