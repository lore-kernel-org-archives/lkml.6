Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDJTSp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:18:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751943AbeDJTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:18:44 -0400
Subject: Re: [PATCH v3] powerpc/64: Fix section mismatch warnings for early
 boot symbols
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, jeyu@kernel.org, jeyu@redhat.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org
References: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <87lgdvbwp8.fsf@concordia.ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 16:18:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87lgdvbwp8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041019-8235-0000-0000-00000D4B3B23
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008832; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01015989; UDB=6.00518083; IPR=6.00795239;
 MB=3.00020506; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-10 19:18:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041019-8236-0000-0000-0000406D901A
Message-Id: <27349037-9412-ae77-7419-a273e54a909d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 11:51 PM, Michael Ellerman wrote:
> Thanks for picking this one up.
> 
> I hate to be a pain ... but before we merge this and proliferate these
> names, I'd like to change the names of some of these early asm
> functions. They're terribly named due to historical reasons.

Indeed :) No worries.

> I haven't actually thought of good names yet though:)
> 
> I'll try and come up with some and post a patch doing the renames.

Alright. Could you please copy me on that, and I can post an update.

cheers,
Mauricio
