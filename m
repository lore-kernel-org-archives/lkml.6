Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AIpwx48cWzvSdNfsTyNp2VDqm9Fx4Ri9HYEno1QpTACXownUGXLGDRv8sQwfalsnBkr/0jSQI/oU
ARC-Seal: i=1; a=rsa-sha256; t=1523449582; cv=none;
        d=google.com; s=arc-20160816;
        b=U+qhCnTLsX4O51iSKVx7l9RtgEOjtJupRW9D33zlRKIn3Nmm2/SZlJBAX9ZWBJFKl9
         tXpX7pKzdibdYMokig9v3L78LSeU35fkS8V+V4GTLOZhSyVzOMji1lHPaE3fYRgvEPEA
         V5FhqU65UfTdL+ab7c7wBYO21loG/AtJOCy2u4jK/5f822Th1orES3ZDCUKZaSjxpsBD
         rxIENda2oaDNL20gAr94wMPgbHKJRPOrGJLySSknEkpkGTOmQnbeA2BfpgIUTZ169eFp
         LP6G472ThqlmL58rmeLPuzJSAUBgc2btDCYUIg0eE15HNVKHfMIEOo7V/UvKdGBSkgDM
         D3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=Hu/R64pKWKRI1Y30/sF2MO0Mjt4FzxPFkIHiiLdls40=;
        b=erFQ09pHYCBuGqZJScBq+8rOgvDLhzMARCExTMf6sLMXEJ/9sQPUm8XUekOVebR76O
         NcWMuQcA2Zqrbu+vo4i8KORu+x7E9s3GP/B4BxmAegp21RTmgu97EF0+HC0q4f8EsrUS
         igB0jwfZRoaPu/DdtIojyab/ooaPcUd+PeyTaBiQPBQGcmdJ15BLnuKe9/IxFT8u4bcC
         ezIG56xzJegfyjuJITGy2waniMhptV/GiOx/rp+bLIOGABmWh9ztwFmtyEC/1jQYT/up
         qv1mWJF7D/AZjSlkSURLdZzPJdqq6oUDa2v2bzUt03IM4eZmjo4PrhTsWeQR1HRILzIf
         awjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="46046983"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: rodrigo.vivi@intel.com, anusha.srivatsa@intel.com, michal.wajdeczko@intel.com, Greg KH <gregkh@linuxfoundation.org>, airlied@linux.ie, joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
In-Reply-To: <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com> <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
Date: Wed, 11 Apr 2018 15:27:06 +0300
Message-ID: <87lgdugc85.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597423482826443546?=
X-GMAIL-MSGID: =?utf-8?q?1597452668604006694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
> <snip>
>
>>
>> NAK on indiscriminate Cc: stable. There are zero guarantees that older
>> kernels will work with whatever firmware you throw at them.
>>
>
> I included 'Cc: stable' so the patch would get added to the v4.16 and
> v4.15 kernels which I have tested with the patch. I found that earlier
> kernels didn't support the 'linux-firmware' package required to get
> wifi working on Intel's new Gemini Lake NUC.

You realize that this patch should have nothing to do with wifi?

Rodrigo, Anusha, if you think Cc: stable is appropriate, please indicate
the specific versions of stable it is appropriate for.

BR,
Jani.

>
>>
>> PS. How is this a "RESEND"? I haven't seen this before.
>>
>
> It is a 'RESEND' for that very reason. I initially sent the patch to
> the same people as
> a similar patch (https://patchwork.kernel.org/patch/10143637/) however
> after realising
> this omitted required addresses I added them and resent the patch.
>
> Best regards,
> Ian

-- 
Jani Nikula, Intel Open Source Technology Center
