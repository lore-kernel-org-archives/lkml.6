Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVGJo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:09:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751002AbeEVGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:09:42 -0400
Subject: Re: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
References: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
 <be181700-57a5-e4c8-7cd4-88a88b7a51f1@linux.ibm.com>
 <764aa7ae-dcbe-6311-19fd-3d31b18f1645@linux.vnet.ibm.com>
 <c14a2313-28af-15ef-0989-2ab8544de51b@linux.ibm.com>
 <20180518141445.GB32141@kernel.org>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Tue, 22 May 2018 08:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518141445.GB32141@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052206-0020-0000-0000-0000041FC8BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052206-0021-0000-0000-000042B4FFCF
Message-Id: <1ba4f82c-af27-3b88-4997-fe0a5de8f433@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220072
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 04:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 18, 2018 at 01:09:48PM +0200, Thomas-Mich Richter escreveu:
>> On 05/18/2018 12:29 PM, Sandipan Das wrote:
>>> Can you please apply these two patches as well and then re-test?
> 
>>> [1] https://lkml.org/lkml/2018/5/17/112
>>> [2] https://lkml.org/lkml/2018/5/17/113
> 
>> Ahhh, yes that helped. Must have missed it. Thanks for the pointer.
> 
> Cool, can I take that as a Tested-by: Thomas?
> 
> - Arnaldo
> 
Sure

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
