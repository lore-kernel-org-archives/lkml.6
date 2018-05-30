Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeE3NEy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:04:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753014AbeE3NEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:04:48 -0400
Subject: Re: [PATCH 6/8] integrity: Factor out common part of
 integrity_audit_msg()
To: Steve Grubb <sgrubb@redhat.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-7-stefanb@linux.vnet.ibm.com> <2600105.j2Wzuo56oP@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 09:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2600105.j2Wzuo56oP@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18053013-0048-0000-0000-000002729F2F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039827; UDB=6.00532229; IPR=6.00818960;
 MB=3.00021375; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 13:04:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053013-0049-0000-0000-000045455687
Message-Id: <6184c964-9dbb-1f0a-2db7-27a6f2b2bba7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 05:32 PM, Steve Grubb wrote:
> On Thursday, May 24, 2018 4:11:03 PM EDT Stefan Berger wrote:
>> Factor out a common part of integrity_audit_msg() that others
>> can also call.
> After all of these changes, do you mind sending an example event for testing/
> review?

Adding example to 5/8 since this patch here doesn't change any records.
