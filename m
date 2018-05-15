Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeEOObJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:31:09 -0400
Received: from mx1.emlix.com ([46.4.235.150]:44688 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeEOObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:31:06 -0400
Subject: Re: [PATCH] Input: ili251x - add support for Ilitek ILI251x
 touchscreens
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh@kernel.org, mark.rutland@arm.com, rydberg@bitmath.org,
        andi@etezian.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180507131823.28800-1-pp@emlix.com>
 <20180509224152.GB91762@dtor-ws>
From: Philipp Puschmann <pp@emlix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pp@emlix.com; prefer-encrypt=mutual; keydata=
 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
 nkFFRXn8
Message-ID: <ea37e29e-5cf4-5135-041d-b8be20cc17f2@emlix.com>
Date: Tue, 15 May 2018 16:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509224152.GB91762@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
hi Rob,
hi Andi,

thank you for your replies and your helpful hints. I will take care of them and
send a V2 of this driver + dt-bindings soon. As i have a working version of this
driver working on it has not a very priority so it may need some time.

Most of your points are correct and don't need further discussion. For the pressure
data i'm unsure, see below.

Am 10.05.2018 um 00:41 schrieb Dmitry Torokhov:
>> The usage of pressure is optional. Touchscreens may deliver constant
>> and so useless pressure data.
> 
> Is it dependent on model or what? I would much rather we did not have DT
> property for this.
I don't know. My touchscreen here delivers a constant (useless) pressure of
10. So my chip delivers "something". I'm not sure if the chip always delivers
no real pressure data or if this is dependent from the wiring.
This was the reason i put it in the dt.


Thanks
Philipp

-- 
Bitte beachten Sie unsere neue Adresse am Göttinger Standort:
emlix GmbH, Gothaer Platz 3, 37083 Göttingen

Philipp Puschmann, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Goettingen HR B 3160
Geschaeftsführung: Heike Jordan, Dr. Uwe Kracke
Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source
