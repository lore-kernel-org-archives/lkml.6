Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeENJST (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:18:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43849 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeENJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:18:18 -0400
Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
To: Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
 <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
 <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Bastian Stender <bst@pengutronix.de>
Message-ID: <1c485c97-f667-7cbd-a6a0-bc74d8aa0918@pengutronix.de>
Date: Mon, 14 May 2018 11:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:7c06:bf8a:7e39:c388
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 11:10 AM, Anson Huang wrote:
>> -----Original Message-----
>> From: Bastian Stender [mailto:bst@pengutronix.de]
>> Sent: Monday, May 14, 2018 4:37 PM
>> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> rjw@rjwysocki.net; viresh.kumar@linaro.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Cc: devicetree@vger.kernel.org; linux-pm@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
>>
>> Hi,
>>
>> On 05/14/2018 10:09 AM, Anson Huang wrote:
>>> This patch removes cpufreq cooling registration in thermal .probe
>>> function, cpufreq cooling should be done in cpufreq driver when it is
>>> ready.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>
>> It seems you are trying to achieve something similar to a patch I sent a couple
>> of month ago. Unfortunately I did not have the time to rework it yet:
>>
>>
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
>> work.kernel.org%2Fpatch%2F10059085%2F&data=02%7C01%7Canson.huang
>> %40nxp.com%7C179da3635cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6f
>> a92cd99c5c301635%7C0%7C0%7C636618838508978629&sdata=BcQ9tc%2BE
>> CZ%2Fk4AsZFxshgmvSsPg7eRN0ASzP8LO8yBI%3D&reserved=0
>>
>> Some of the comments might apply here too.
> 
> Ah, I did NOT notice this thread, so how to proceed, will you 
> continue to finish your patch? If yes, then you can just ignore/skip
> my patch, thanks.
Yes, I will revisit the patch in a couple of weeks. It would be nice to
get your feedback then.

Regards,
Bastian	

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
