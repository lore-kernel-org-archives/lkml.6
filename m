Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeDDRNg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:13:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752316AbeDDRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:13:34 -0400
Subject: Re: [PATCH] tools: restore READ_ONCE() C++ compatibility
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 22:43:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180404163445.16492-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040417-0040-0000-0000-0000042A7321
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040417-0041-0000-0000-0000262DA621
Message-Id: <7fb04d1a-79a9-0896-577b-193458e1cd48@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 04/04/2018 10:04 PM, Mark Rutland wrote:
> 
> Zhijian, Sandipan, does this patch work for you?
> 

Yes it does. Thanks for the fix.

- Sandipan
