Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeEHBvB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:51:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40609 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeEHBu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:50:58 -0400
X-Google-Smtp-Source: AB8JxZo2Hh/Db0yGaxSdiY6Zf9bZbor5nfnNxewJo0Ad72rUlYx/WGYpiF9sAKcTz20rrn0rs/KSqWDTBvgtqTjkBhE=
MIME-Version: 1.0
In-Reply-To: <20180507211041.GA10205@rob-hp-laptop>
References: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
 <20180507211041.GA10205@rob-hp-laptop>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 8 May 2018 09:50:57 +0800
Message-ID: <CAMz4kuLp=9Ae1UEE8LqoxBQneQ-x9T__WQ-zmtFf3n1AUUkUHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
To: Rob Herring <robh@kernel.org>
Cc: jacek.anaszewski@gmail.com, Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>, xiaotong.lu@spreadtrum.com,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8 May 2018 at 05:10, Rob Herring <robh@kernel.org> wrote:
> On Fri, May 04, 2018 at 06:08:35PM +0800, Baolin Wang wrote:
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> breathing light controller, which supports 3 outputs: red LED, green
>> LED and blue LED.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   39 ++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> new file mode 100644
>> index 0000000..d4e267d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> @@ -0,0 +1,39 @@
>> +LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
>> +
>> +The SC27xx breathing light controller supports to 3 outputs:
>> +red LED, green LED and blue LED. Each LED can work at normal
>> +PWM mode or breath light mode.
>> +
>> +Required properties:
>> +- compatible: should be "sprd,sc27xx-bltc".
>
> Don't use wildcards in compatible strings.

Will change to one explicit Soc name. Thanks.

-- 
Baolin.wang
Best Regards
