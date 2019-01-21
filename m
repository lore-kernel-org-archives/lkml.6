Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55527C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B952085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAUVPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:15:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbfAUVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:15:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LLER4B072536
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:15:40 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5jywx85e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:15:40 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 21 Jan 2019 21:15:39 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 21:15:35 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LLFYHh25755896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 21:15:34 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 976B36A051;
        Mon, 21 Jan 2019 21:15:34 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86B816A04F;
        Mon, 21 Jan 2019 21:15:31 +0000 (GMT)
Received: from oc6728276242.ibm.com (unknown [9.85.171.190])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 21:15:31 +0000 (GMT)
Subject: Re: [PATCH 1/2] hwmon (occ): Fix license headers
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com>
 <1548100592-50383-2-git-send-email-eajames@linux.ibm.com>
 <CACPK8XeRgCRmyFFxrwCGKnBm=+o=m_L6G=ZWftOV_QB7ATjxow@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Mon, 21 Jan 2019 15:15:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XeRgCRmyFFxrwCGKnBm=+o=m_L6G=ZWftOV_QB7ATjxow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19012121-0016-0000-0000-00000978B22F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149830; UDB=6.00599159; IPR=6.00930155;
 MB=3.00025227; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-21 21:15:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012121-0017-0000-0000-000041DC3C45
Message-Id: <0566a8cf-b9f3-617a-712e-95c92cf8af70@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/21/2019 02:19 PM, Joel Stanley wrote:
> On Tue, 22 Jan 2019 at 06:56, Eddie James <eajames@linux.ibm.com> wrote:
>
>> --- a/drivers/hwmon/occ/common.h
>> +++ b/drivers/hwmon/occ/common.h
>> @@ -1,4 +1,5 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright IBM Corp 2019
> We want to use the /* */ syntax for headers. Take a closer look at
> Documentation/process/license-rules.rst:

Oops. Do I put the copyright in the copyright in the same comment block 
then? Or use // for that?

>
> 2. Style:
>
>     The SPDX license identifier is added in form of a comment.  The comment
>     style depends on the file type::
>
>        C source: // SPDX-License-Identifier: <SPDX License Expression>
>        C header: /* SPDX-License-Identifier: <SPDX License Expression> */
>

