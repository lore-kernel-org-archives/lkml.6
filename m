Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeFDLpP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:45:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752141AbeFDLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:45:13 -0400
Date: Mon, 4 Jun 2018 17:15:00 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18060411-0020-0000-0000-000002967C82
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060411-0021-0000-0000-000020E21116
Message-Id: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=934 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
> Is this a new property ? I'm not fan of adding yet another of those
> silly arrays.
> 
> I would say this is the right time now to switch over to a node per
> state instead, as we discussed with Vaidy.

I posted  the node based device tree here :
skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
kernel patch : https://lkml.org/lkml/2018/5/30/1146

Do you have any inputs for this design ?

> 
> Additionally, while doing that, we can provide the versioning mechanism
> I proposed so we can deal with state specific issues and erratas.
> 
> Cheers,
> Ben.
> 
