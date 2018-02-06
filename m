Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeBFMsE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:48:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752807AbeBFMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:47:48 -0500
Date: Tue, 6 Feb 2018 04:47:39 -0800
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        wangnan0@huawei.com, masami.hiramatsu.pt@hitachi.com,
        keescook@chromium.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18020612-0020-0000-0000-000003F2D2CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020612-0021-0000-0000-0000428549E9
Message-Id: <20180206124739.GA57073@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Simplify probes_seq_show() function. We are using %lx to display
> the offset and we don't prepend unnecessary 0s in the offset.
> 


The prepending of 0s was introduced by 
tracing/uprobes: Do not print '0x (null)' when offset is 0
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2fb3382

Wan, 
Was there a reason to prepend 0s?
