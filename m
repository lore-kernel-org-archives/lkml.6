Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeFARNi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:13:38 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45619 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeFARNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:13:32 -0400
X-Google-Smtp-Source: ADUXVKIFLPoXpaB0eUC82ZE9kXXPPN0MBJItV7DNU+7MeV1Euijh4LGwkwpCfT/GY8eEnNH9/E7j5Ygd7el3STpBjCk=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com> <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
 <38f21c66-fa34-3a77-33bc-d15065c15af9@zytor.com> <CAKwvOdkurUGcSAGjR8_nDRgHLFLj93E1wAA3+O0A+pKPHvzwRA@mail.gmail.com>
 <CAKwvOd=FN0G-zs-DMF3ubs8y9-PDEamfi__P_iv_JgN3bH6qFw@mail.gmail.com>
In-Reply-To: <CAKwvOd=FN0G-zs-DMF3ubs8y9-PDEamfi__P_iv_JgN3bH6qFw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 1 Jun 2018 10:13:19 -0700
Message-ID: <CAKwvOd=8torqMSGr8-1yPzNdom+is2dFpNeHSatyqeLBMyieZg@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:50 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Will do further testing and cut a patch set tomorrow.

https://lkml.org/lkml/2018/6/1/679
(sorry, should have re-cc-ed everyone from this thread, will try to
re-add when there's feedback)
-- 
Thanks,
~Nick Desaulniers
