Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933096AbeBMBDD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:03:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933043AbeBMBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:03:01 -0500
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
To: Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180126140415.GD5027@dhcp22.suse.cz>
 <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
 <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
 <20180201134829.GL21609@dhcp22.suse.cz>
 <20180212144831.GF3443@dhcp22.suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, broonie@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 06:32:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180212144831.GF3443@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021301-0008-0000-0000-000004CC1883
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021301-0009-0000-0000-00001E5FD7B4
Message-Id: <f81a5ef6-724a-6667-c5ce-47a6b1706c2c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130009
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 08:18 PM, Michal Hocko wrote:
> Did you have any chance to test the following hack, Anshuman?

The system has some issues at the moment, will get back on this.
