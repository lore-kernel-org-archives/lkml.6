Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06074C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A012081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A012081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeKFF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:58:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44019 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKFF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:58:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id k9so9303434otl.10;
        Mon, 05 Nov 2018 12:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x1cXK7d3XogSrQZz3j0da95VPDbe5OzopYvsUml50B4=;
        b=PeitcmsELb/0OIJ6R+DLLNrNYU9GzUnbLPA7CDq0j16jYSXZ6DFQxDBnEpij/uRS/j
         XcGNfA7Ogg6LHjhqkN3U720h/g7vORJHFdyvnWdtBv9Ymv5LFSgFowskdYnnC6gV3pWD
         3wtf1ubhnsZVQH545UWoFxBeMo1gfc1bj3jSgoqhlGeYgZ4mhhrYDi1tEFDKg92t/0CC
         P2yiz+dhVCMIoWb9/9W5RNrststIcw2p+KC8uIR9w1cUej09yWJx1NqYwrVSmWq8ulxp
         P2E8cDQO6kNrY+/TkdoY3EDJv1gbJccEAdzTs9xxyEuN7ZLlioPh5kxZOM3L9Kvf2OmI
         gVpA==
X-Gm-Message-State: AGRZ1gKO63KPDVyjkR7zyR0lvnhYxIYSxFVkGAqyLyt0CaIJnGnArnvh
        JcJBeMYiB++BF7Mq3gGRaQ==
X-Google-Smtp-Source: AJdET5eT9f6xW9J7vZyuXxqe0VJ5JmHrKXTBt2NSZBHmBh8zFm997ZS+RE1+VnXaASKC1UnDVoAnQw==
X-Received: by 2002:a9d:4c88:: with SMTP id m8mr2571260otf.360.1541450219035;
        Mon, 05 Nov 2018 12:36:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm8671259oth.5.2018.11.05.12.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:36:58 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:36:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@google.com>
Cc:     vbadigan@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
Message-ID: <20181105203657.GA32282@bogus>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
 <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 01:29:54PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
> >
> > For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
> >
> > Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > index 502b3b8..f2ffbeb 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > @@ -7,6 +7,7 @@ Required properties:
> >  - compatible: Should contain:
> >                 "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> >                 "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> > +               "qcom,sdm845-sdhci" for sdm845 SOC
> 
> It's up to Rob of course, but IMO it seems a nicer way forward to
> include both the SoC-specific string and the "version" string in all
> cases.  I'd write this for the full text:

Fine by me if you update all the dts files.

> 
>  - compatible: Should contain a SoC-specific string and a IP version string:
>       version strings:
>            "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>            "qcom,sdhci-msm-v5" for sdcc version 5.0
>       full compatible strings with SoC and version:
>            "qcom,apq8084", "qcom,sdhci-msm-v4"
>            "qcom,msm8974", "qcom,sdhci-msm-v4"
>            "qcom,msm8916", "qcom,sdhci-msm-v4"
>            "qcom,msm8992", "qcom,sdhci-msm-v4"
>            "qcom,msm8996", "qcom,sdhci-msm-v4"

I assume you meant to append '-sdhci' here?

>            "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> 
>    NOTE that some old device tree files may be floating around that only
>    have the string "qcom,sdhci-msm-v4" without the SoC compatible string
>    but doing that should be considered a deprecated practice.
> 
> -Doug
