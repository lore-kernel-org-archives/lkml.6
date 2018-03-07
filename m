Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeCGRtE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:49:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933533AbeCGRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:49:00 -0500
Subject: Re: [PATCH 1/3] certs: define a trusted platform keyring
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
 <31489.1520438598@warthog.procyon.org.uk>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 23:17:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <31489.1520438598@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030717-0048-0000-0000-00000246326B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008630; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999668; UDB=6.00508501; IPR=6.00779073;
 MB=3.00019896; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 17:48:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0049-0000-0000-0000445D3122
Message-Id: <8873df7f-490f-28e0-249e-34bb3b133015@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 09:33 PM, David Howells wrote:
> Nayna Jain <nayna@linux.vnet.ibm.com> wrote:
>
>> +		key = key_create_or_update(make_key_ref(keyring, 1),
>> +				"asymmetric",
>> +				NULL,
>> +				p,
>> +				plen,
>> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>> +				 KEY_USR_VIEW | KEY_USR_READ),
>> +				KEY_ALLOC_NOT_IN_QUOTA |
>> +				KEY_ALLOC_BUILT_IN |
>> +				KEY_ALLOC_BYPASS_RESTRICTION);
> There's no need to reindent here.  Please line up all the arguments: either
> push the first argument over onto the next line if you need to or line them
> all up with the char after the opening bracket.

Thanks David for the feedback. I will post the v2 version with this fix. 
Are there any other changes ?

Thanks & Regards,
    - Nayna

>
> David
>
