Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBIPII (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:08:08 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43732 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeBIPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:08:07 -0500
X-Google-Smtp-Source: AH8x2241/FhAiVEVbIK1CoMym60q8grnAMKSP0TLMzzkZomBeKQJXazQu0+fo5ygDCHSuZ8BU7rnshzO5mf1mpk3Ka8=
MIME-Version: 1.0
In-Reply-To: <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
 <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com>
 <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com> <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 9 Feb 2018 23:07:46 +0800
Message-ID: <CAErzpmvANGPPKmhH-JFYO-AMeXhdnt-4O3WCG1rC1J3tOM3DWQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 10:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 4:43 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> There is some duplicate code in soc-core.c, and the kernel provides
>> DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.
>>
>
> You missed my tag.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Sorry, I got it.
