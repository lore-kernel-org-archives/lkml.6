Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeDZLZO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:25:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754484AbeDZLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:25:13 -0400
Date: Thu, 26 Apr 2018 13:25:04 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Arend van Spriel <arend.vanspriel@broadcom.com>
cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
Subject: make TAGS broken with commit 99443f811c452c6 ("scripts/tags.sh:
 change find_other_sources()...")
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18042611-0040-0000-0000-0000043351A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042611-0041-0000-0000-000026375765
Message-Id: <alpine.LFD.2.21.1804261311150.1592@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260110
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my s390 test system make TAGS is broken since commit 99443f811c452c6
("scripts/tags.sh: change find_other_sources() for include directories")

# make TAGS
  GEN     TAGS
xargs: etags: terminated by signal 11

This is a rather old etags from fedora 24. On x86 using a more recent
etags (fedora 27) make TAGS works as expected. I'll try to update the
test system maybe that'll fix the problem..

Regards,
Sebastian
