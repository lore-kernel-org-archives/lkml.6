Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524501039; cv=none;
        d=google.com; s=arc-20160816;
        b=OdEe+NxfcaiLrb2nRvNF9qkVVaUiyVSn7JMOtEe27ISsDKB1GB+gZYBFuiDAZEsr19
         iyBiiiWIXLDAWXlYkW3L3gzQKrNmmTARdghLEwp8HfJrWc/1cF5n3OK/35HN8BXBSiU/
         cNiJaNOenLckwc+AXOi2mx825BG1G3Y13cjn4LB4zLBDXqkiaQdKJSzGkp7jkT8dhgbS
         DlSuANfvfQ5ZgamfAfMPS5l1fm8tcfqXSKMEXF07Y68hOkhf/2HHAXS9XWdPKoOB3ian
         +00oXx9XbUOkgaOb1cPawGqoqjodkx+Ql35oZX84gDkPE2GPPpf8AhGObAUz+iMbYgxA
         WZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+wItm1SQFCcvkGGR9t6Qd6qddyyX5QHwxHumw3SrmGk=;
        b=YvSOv+NlnSf7UPRtOUf1cdZTcz5czggNNqApnPtxwAIrMLD8vNiv32RETQJ4InVfzP
         TpK7c3Js8AU7u30v9Q8T+EpfwTaEJ6xQTJ4U51oEJo/X+aQQQq2xamdL5yUjwf9r8ZT/
         aZflK0tJYQrNQfYc+PxroxhqwsbrDHmt+IhwKMN31vs6Lu7dCttx0Z8WOhZ5jA7D56ra
         Tf8ijoKNOUqO7XCHDvASMzA/Iwyq1lXd8uLo85IGNdmDec+V0D6xS823nDNPiBSItwFK
         HBmxNt93zJmso1J1zGPwdym713LF6Z9U0pv+YaIeLRNTPKhDIfL/RsIZ55hvqwva5Kea
         jQEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=a3JwJCbK;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=a3JwJCbK;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+vz3gIfxyj+WPIE8uFRptD4P1rP6xKJ1fG9z/Y9D+mDd47/Rz38Fd9YkyhSj1MbG12ZJVARwEXy9qK0BkMTUA=
MIME-Version: 1.0
In-Reply-To: <20180423113828.GA8720@kroah.com>
References: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org> <20180423113828.GA8720@kroah.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 23 Apr 2018 10:30:38 -0600
Message-ID: <CANLsYkyyRdyFOANZH8oprxuF9n9rFXj_mXasyeOuCp-sb5ZOsg@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: Moving framework and drivers to SPDX identifier
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937409545454672?=
X-GMAIL-MSGID: =?utf-8?q?1598555201131983082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 April 2018 at 05:38, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 17, 2018 at 10:16:57AM -0600, Mathieu Poirier wrote:
>> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>> Change for V2:
>> * Added drivers/hwtracing/stm/ftrace.c as pointed out by Alex.
>
> This doesn't apply to 4.17-rc2 :(

My goal was to "socialise" the patch before including it in my tree
where there are other dependencies.  I will send you the whole tally
around rc3 or rc4, as usual.

Thanks,
Mathieu

>
> thanks,
>
> greg k-h
