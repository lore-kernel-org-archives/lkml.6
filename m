Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524588557; cv=none;
        d=google.com; s=arc-20160816;
        b=jUQNSdwbwAxQPUkgjk2U8UI9X8u3Uqw98hdtl18FMktG59FEvCiSyrlKk7clPc/QHV
         R8yw8/zs3zY1b2EKH0k81aoDnbHTh1XLDqluaisl71XEdsuZ2D1b4Rp9WqTkmakUKRuP
         3fzmsDSX6FNqQV56Ga9IpBVqLgnTYjDJm0ZOjujWV7AtUw+HjyyenO6+ZQfIg1K1yA+/
         TLkEOD1zPWLqqHBPSA3RxyYVSa+pWw6U/fEmxNSWz2snt/GKCKMTOaaYWKwrQKgFPRX5
         vx9BmVDesiF7OXlGAHpp7MUvonoG55K65uBsAiJ36LwGESZ+QQpmbEKbRIlLu7jaMMUJ
         yvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=A/mHDgTjLf0iHC6tnxXfTdhjKm0Wupg3Hz0oLZXd1nM=;
        b=GmvEE6YIaQIJY/ED+nbhprLN8CqFgPmQ9LX0kZ0k8VNx1rwTJxr82zGh4LbgDDqR54
         TR8FWYJG9mMTp3SYzMvBxYtgeOb4KDiBXpvbJ4kMp8qOEYnd8tN7z++JR4Q/qLhszOY4
         0OHnjVrs7eFQeA0R4Zr3YTR3lf4F5qrR4oNpi7EZhI2M2QZt6ykeAslfld8/+bUcmSdo
         NtFgMx849/KY4mzK0wR3h9cAW+DLTi13OUT3sA+frj8gaA3hSh8ZrNrJKlj92Me2rBD5
         TfKaISIhAKp7Kf3uAUwvvFCyBcaXcAugjNg5+jVdDp16OaV4FXSv3xXaopulCysMAmJd
         +TVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KNSDQiax;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KNSDQiax;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+vgCUXrCwu6nUHF1r3WNSjBy3nt96cqdQOHN2lsLA8mCpxpFRGZmrj5VJXBIzImSEHjI1ODw==
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, tiwai@suse.com,
 perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
Date: Tue, 24 Apr 2018 17:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598646971456348013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review.

On 24/04/18 17:25, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 76 ++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>> new file mode 100644
>> index 000000000000..37e23d926b95
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>> @@ -0,0 +1,76 @@
>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>> +
>> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apq8096-sndcard"
>> +
>> +- qcom,audio-routing:
>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board:
> 
> Please list out valid values here.

I can list the values for the HDMI playback use-case, but the list would 
grow as we start adding wcd9335 codec support.

> 
>> +
>> += dailinks
>> +Each subnode of sndcard represents either a dailink, and subnodes of each
>> +dailinks would be cpu/codec/platform dais.
>> +
>> +- link-name:
> 
> Not a standard property, but I guess that sneaked in with the 8016
> binding...
Yes, I followed 8016 bindings.

Am happy to prefix this with qcom if that makes more sense.
> 
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: User friendly name for dai link
>> +
>> += CPU, PLATFORM, CODEC dais subnodes
>> +- cpu:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: cpu dai sub-node
>> +
>> +- codec:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: codec dai sub-node
>> +
>> +- platform:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: platform dai sub-node
>> +
>> +- sound-dai:
>> +	Usage: required
>> +	Value type: <phandle>
> 
> phandle with args.
Yep.

--srini
