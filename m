Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDQIxN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:53:13 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53224 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751147AbeDQIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:53:12 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v9 7/9] pinctrl: madera: Add DT bindings for Cirrus Logic
 Madera codecs
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180313131904.13700-1-rf@opensource.cirrus.com>
 <20180313131904.13700-8-rf@opensource.cirrus.com>
 <CACRpkdZspUbmCk7OwA-rva6zd89TZXt45t5mFes0feuRyOUp9w@mail.gmail.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <bc752fb8-8f2f-70bc-e786-221eb39c618b@opensource.cirrus.com>
Date: Tue, 17 Apr 2018 09:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZspUbmCk7OwA-rva6zd89TZXt45t5mFes0feuRyOUp9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804170080
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/18 12:29, Linus Walleij wrote:
> On Tue, Mar 13, 2018 at 2:19 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
>> This is the binding description of the pinctrl driver for Cirrus Logic
>> Madera codecs. The binding uses the generic pinctrl binding so  the main
>> purpose here is to describe the device-specific names for groups and
>> functions.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I can also just apply this if you want, as it has no dependencies to
> anything else. I just assume you want to keep it together with the
> rest of this complex series.
> 
> Yours,
> Linus Walleij
> 

Linus,

What is your opinion of the i.MX6 pinctrl failure after my bugfix patch
for the hogs?
If you would want to revert my patch I would need to change this pinctrl
driver so it has its own child node as a workaround to the hog bug.

Or do you think it is more likely a bug in the i.MX6 pinctrl driver?
