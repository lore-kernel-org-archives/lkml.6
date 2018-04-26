Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756010AbeDZMk4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:40:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754277AbeDZMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:40:55 -0400
Date: Thu, 26 Apr 2018 14:40:46 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Arend van Spriel <arend.vanspriel@broadcom.com>
cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: make TAGS broken with commit 99443f811c452c6 ("scripts/tags.sh:
 change find_other_sources()...")
In-Reply-To: <alpine.LFD.2.21.1804261311150.1592@schleppi>
References: <alpine.LFD.2.21.1804261311150.1592@schleppi>
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
x-cbid: 18042612-0044-0000-0000-0000054C58A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042612-0045-0000-0000-0000288D5F74
Message-Id: <alpine.LFD.2.21.1804261438580.1592@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Sebastian Ott wrote:
> on my s390 test system make TAGS is broken since commit 99443f811c452c6
> ("scripts/tags.sh: change find_other_sources() for include directories")
> 
> # make TAGS
>   GEN     TAGS
> xargs: etags: terminated by signal 11
> 
> This is a rather old etags from fedora 24. On x86 using a more recent
> etags (fedora 27) make TAGS works as expected. I'll try to update the
> test system maybe that'll fix the problem..

Using the same etags version as on x86 now but it still fails.

Regards,
Sebastian
