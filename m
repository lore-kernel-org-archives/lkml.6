Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeFDO6l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:58:41 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:54494 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbeFDO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:58:39 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <65c26f5db1275e958cfe6390e9336568b0158dea.camel@linux.intel.com>
 <CAJs94EZEEBNZRU3ixkdG9w44xsQDi7MUYAya2dzkAErT=xwqVA@mail.gmail.com>
 <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
 <7bdb658727b364e275c121a3bdd351f183d56cb9.camel@linux.intel.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <ec7fc614-63a4-9dcd-c83c-00628f8af2b1@micronovasrl.com>
Date: Mon, 4 Jun 2018 16:58:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7bdb658727b364e275c121a3bdd351f183d56cb9.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Il 04/06/2018 13:44, Andy Shevchenko ha scritto:
> On Mon, 2018-06-04 at 12:42 +0200, Giulio Benetti wrote:
> 
>>>> I don't see in Cc list author of rs485 code, who might be
>>>> interested in
>>>> this.
>>>>
>>>> So, added him here.
>>
>> Thanks Andy for adding in Cc an reviewing.
>> Dumb question: how did you find him?
> 
> I'm just following mailing lists somehow.
> Though you always can do `git annotate` to see who lately did change
> what.
> 
>> I thought he was between people on get_maintainer.pl output.
> 
> Hmm... probably. Never checked myself for this particular case.
> 

Ok, thank you.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
