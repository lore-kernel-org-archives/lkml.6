Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968723AbeE3JcH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:32:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965209AbeE3JcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:32:05 -0400
Subject: Re: [PATCH] scsi: qla2xxx: Fix crash on qla2x00_mailbox_command
Cc: maurosr@linux.vnet.ibm.com, kernel@gpiccoli.net,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        qla2xxx-upstream@qlogic.com
References: <1527530324-32359-1-git-send-email-rosattig@linux.vnet.ibm.com>
From: Rodrigo Rosatti Galvao <rosattig@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 06:31:56 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527530324-32359-1-git-send-email-rosattig@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18053009-0020-0000-0000-00000E0B18B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039774; UDB=6.00532197; IPR=6.00818907;
 MB=3.00021373; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 09:32:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053009-0021-0000-0000-000061A744AD
Message-Id: <665a155d-f45c-491c-ed24-51f0796d99f8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300110
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I just forgot to loop the Qlogic list. [qla2xxx-upstream@qlogic.com]

-- 
Rodrigo R. Galvão
Intern - Linux Technology Center - IBM
