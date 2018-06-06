Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="RwpTsBpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C150760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeFFJhB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:37:01 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:54862 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932472AbeFFJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:36:59 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
 <b14d4970-f14d-d59f-2072-b7d5704dd842@gmail.com>
 <d130718a-444d-3a39-4da8-0f0b907f850d@micronovasrl.com>
 <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <2654fba0-e16e-4f53-4913-bd718e42497c@micronovasrl.com>
Date: Wed, 6 Jun 2018 11:36:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 05/06/2018 12:51, Matwey V. Kornilov ha scritto:
> Could I ask to split the series into fixes and new features? I see
> that the fixes can be applied, probably it would be better to apply
> them separately from discussing new features.

Sure, I'm going to send 2 different patchsets.

Thanks

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
