Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeBZLrN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:47:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752048AbeBZLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:47:10 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
In-Reply-To: <877er9l6jo.fsf@concordia.ellerman.id.au>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com> <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com> <8737264c91.fsf@vajain21.in.ibm.com> <87eflnre7w.fsf@concordia.ellerman.id.au> <87d116wy6g.fsf@vajain21.in.ibm.com> <877er9l6jo.fsf@concordia.ellerman.id.au>
Date: Mon, 26 Feb 2018 17:16:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022611-0016-0000-0000-00000529EA4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022611-0017-0000-0000-000028661191
Message-Id: <87fu5o7z2k.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback Mpe,

I have sent-out a new patch incorporating your review comments at
http://patchwork.ozlabs.org/patch/877792/

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
