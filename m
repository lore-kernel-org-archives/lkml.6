Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeEKBv5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:51:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751856AbeEKBvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:51:54 -0400
Subject: Re: [PATCH v2 2/4] tpm: Move eventlog files to a subdirectory
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thiebaud Weksteen <tweek@google.com>, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltp <ltp@lists.linux.it>
Date: Thu, 10 May 2018 21:51:47 -0400
In-Reply-To: <20180509145121.z3jmvznojhi5mjiz@dell5510>
References: <20180412101350.210547-1-tweek@google.com>
         <20180412101350.210547-3-tweek@google.com>
         <20180420053926.GB15364@linux.intel.com>
         <1525725397.3551.10.camel@linux.vnet.ibm.com>
         <20180509145121.z3jmvznojhi5mjiz@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051101-0020-0000-0000-0000041C14F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051101-0021-0000-0000-000042B11581
Message-Id: <1526003507.3545.4.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 16:51 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > [Cc'ing Petr Vorel and the ltp mailing list]
> 
> > Hi Jarrko,
> 
> > On Fri, 2018-04-20 at 08:39 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Apr 12, 2018 at 12:13:48PM +0200, Thiebaud Weksteen wrote:
> > > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> > I just noticed this is queued in your next branch.
> 
> > Petr Vorel has been updating the IMA LTP tests.  One of those IMA LTP
> > tests includes walking the TPM binary_runtime_measurements in order to
> > calculate the IMA boot-aggregate.  The IMA boot-aggregate is the first
> > measurement in the IMA measurement list.
> 
> Did you meant that this commit ([2]) in linux-tpmdd/next changed location of
> binary_runtime_measurements in sysfs?
> 
> IMHO these commits ([1], [2], [3]) just put source code into eventlog/ subdirectory:

I mistakenly thought the eventlog itself was being moved, not the
source code.

thanks,

Mimi

> 
> Kind regards,
> Petr
> 
> [1] 75d647f5de69 tpm: Move eventlog declarations to its own header
> [2] 9b01b5356629 tpm: Move shared eventlog functions to common.c
> [3] 0bfb23746052 tpm: Move eventlog files to a subdirectory
> 
