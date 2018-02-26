Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBZPhF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:37:05 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:33942 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751954AbeBZPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:37:02 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v8 3/9] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
To: Fabio Estevam <festevam@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20180226130558.7634-1-rf@opensource.cirrus.com>
 <20180226130558.7634-4-rf@opensource.cirrus.com>
 <CAOMZO5DEiwUBsMWfR-a6UgEkEeXvWqXPFAf0pPcwpeJY540xGg@mail.gmail.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <d541ca7e-5e02-a7e5-07c5-38fdebbbc014@opensource.cirrus.com>
Date: Mon, 26 Feb 2018 15:36:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DEiwUBsMWfR-a6UgEkEeXvWqXPFAf0pPcwpeJY540xGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=741 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802260207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 13:58, Fabio Estevam wrote:
> On Mon, Feb 26, 2018 at 10:05 AM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
>> --- /dev/null
>> +++ b/drivers/mfd/madera-core.c
>> @@ -0,0 +1,602 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> As you use SPDX line here....
> 
>> +/*
>> + * Core MFD support for Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
> 
> You can remove this paragraph.
> 
> Same applies to the other places of this series.
> 

Our legal team says no, these lines should stay.
