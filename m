Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeEGUgs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:36:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753031AbeEGUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:36:45 -0400
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ltp <ltp@lists.linux.it>,
        Petr Vorel <pvorel@suse.cz>
Date: Mon, 07 May 2018 16:36:37 -0400
In-Reply-To: <20180420053926.GB15364@linux.intel.com>
References: <20180412101350.210547-1-tweek@google.com>
         <20180412101350.210547-3-tweek@google.com>
         <20180420053926.GB15364@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050720-0012-0000-0000-000005D3B7CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050720-0013-0000-0000-00001950C35F
Message-Id: <1525725397.3551.10.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing Petr Vorel and the ltp mailing list]

Hi Jarrko,

On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I just noticed this is queued in your next branch.

Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
tests includes walking the TPM binary_runtime_measurements in order to
calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
measurement in the IMA measurement list.

Mimi
