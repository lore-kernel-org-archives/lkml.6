Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeBRArS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 19:47:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751083AbeBRArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 19:47:16 -0500
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format
 description
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: hpa@zytor.com, Taras Kondratiuk <takondra@cisco.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Rob Landley <rob@landley.net>, Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Date: Sat, 17 Feb 2018 19:47:06 -0500
In-Reply-To: <117FCFDB-EA4C-4C0C-A01E-7C6C86693E6F@zytor.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
         <1518813234-5874-2-git-send-email-takondra@cisco.com>
         <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
         <1518912912.5667.277.camel@linux.vnet.ibm.com>
         <117FCFDB-EA4C-4C0C-A01E-7C6C86693E6F@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021800-0040-0000-0000-00000434D393
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021800-0041-0000-0000-000020D6DB90
Message-Id: <1518914826.5667.288.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802180008
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-17 at 16:26 -0800, hpa@zytor.com wrote:

> Do you have a description of the gaps you have identified?

Probably the 2016 Linux Security Summit (LSS) integrity status update
has the best list.

http://events17.linuxfoundation.org/sites/events/files/slides/LSS2016-
LinuxIntegritySubsystemStatus.pdf

Mimi
