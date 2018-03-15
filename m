Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeCOVB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:01:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751546AbeCOVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:01:54 -0400
Subject: Re: [PATCH 0/4] Code improvements in integrity and IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 15 Mar 2018 17:01:40 -0400
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031521-0008-0000-0000-000004DE880A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031521-0009-0000-0000-00001E71939F
Message-Id: <1521147700.3547.662.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thiago,

On Wed, 2018-03-14 at 17:20 -0300, Thiago Jung Bauermann wrote:
> Hello,
> 
> These patches come from the "appended signatures support for IMA appraisal"
> series. They are code improvements and cleanups and I decided to submit
> them separately for a couple of reasons:
> 
> 1. they stand on their own and could be included in v4.17;
> 
> 2. this will simplify the original patch series a bit, by having it contain
>    only the patches actually necessary to implement the feature.

Agreed.  The first 3 patches are applied.  The last one, we'll see
about.

Mimi


> 
> These are the changes made to them since v5 of the modsig series:
> 
> - Patch "integrity: Remove unused macro IMA_ACTION_RULE_FLAGS"
>   - New patch.
> 
> - Patch "ima: Improvements in ima_appraise_measurement()"
>   - Moved is_ima_sig() to its own patch (not in this series).
> 
> Mimi Zohar (1):
>   ima: Improvements in ima_appraise_measurement()
> 
> Thiago Jung Bauermann (3):
>   integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
>   ima: Simplify ima_eventsig_init()
>   integrity: Introduce struct evm_xattr
> 
>  security/integrity/evm/evm_crypto.c       |  4 ++--
>  security/integrity/evm/evm_main.c         | 10 ++++----
>  security/integrity/ima/ima_appraise.c     | 40 ++++++++++++++++++-------------
>  security/integrity/ima/ima_template_lib.c | 11 +++------
>  security/integrity/integrity.h            |  6 ++++-
>  5 files changed, 39 insertions(+), 32 deletions(-)
> 
