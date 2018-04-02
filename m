Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeDBQbl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:31:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752813AbeDBQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:31:40 -0400
Subject: Re: [PATCH v2] nvmet: fix nvmet_execute_write_zeroes function
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1522680581-10220-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180402145813.GE28945@localhost.localdomain>
From: Rodrigo Rosatti Galvao <rosattig@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 13:31:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402145813.GE28945@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040216-0028-0000-0000-00000962DF9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008790; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012099; UDB=6.00515790; IPR=6.00791369;
 MB=3.00020377; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 16:31:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040216-0029-0000-0000-00003A362005
Message-Id: <10c64856-15bf-eed8-c9db-33b4d9ea58f3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm terribly sorry, but the +1 actually needs to be outside the
> le16_to_cpu. The above will work on little-endian machines, but not big.

No problem at all. Thank you for helping on this.

I'm going to send a V3 with this change.

-- 
Rodrigo R. Galvão
Intern - Linux Technology Center - IBM
