Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeCPVi4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 17:38:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751236AbeCPVix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 17:38:53 -0400
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 00/12] Appended signatures support for IMA appraisal
In-reply-to: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 18:38:38 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18031621-0016-0000-0000-00000867EAAB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008687; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01004048; UDB=6.00511032; IPR=6.00783338;
 MB=3.00020080; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-16 21:38:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031621-0017-0000-0000-00003DDF48B5
Message-Id: <87zi37og4h.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Now the modsig is only ignored if it references a signature that is not
> present in IMA's keyring (or if there's a parsing error, obviously). If the

The above should read "Now the modsig is only ignored if it references a
*key* that is not present in IMA's keyring".

Sorry, I only noticed the mistake after sending the emails.

--
Thiago Jung Bauermann
IBM Linux Technology Center
