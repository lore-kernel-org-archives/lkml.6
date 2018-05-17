Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeEQFzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:55:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750779AbeEQFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:55:51 -0400
Date: Thu, 17 May 2018 11:25:42 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ego@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87efiby6a9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efiby6a9.fsf@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18051705-0040-0000-0000-0000045A4DB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051705-0041-0000-0000-000020FE8368
Message-Id: <20180517055542.vvpgw2vy2ivowfdc@aksadiga.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes this needs to be sent to  stable. 

Fixes: d405a98c ("powerpc/powernv: Move cpuidle related code from setup.c
to new file")
