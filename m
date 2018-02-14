Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032087AbeBNXTt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:19:49 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:56328 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031971AbeBNXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:19:48 -0500
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Andi Kleen <andi@firstfloor.org>,
        Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [TEST for] fs: global sync to not clear error status of
 individual inodes
Thread-Topic: [TEST for] fs: global sync to not clear error status of
 individual inodes
Thread-Index: AQHTpeeGNVexUNocjkKnaB1YrF5uQKOj8SSA
Date: Wed, 14 Feb 2018 23:18:59 +0000
Message-ID: <b96fe0fc-3128-a5f1-67f6-e33a328c5637@ce.jp.nec.com>
References: <20180214225947.GB1686@wotan.suse.de>
In-Reply-To: <20180214225947.GB1686@wotan.suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <358B3C127BCD2A448C28CB4E63D4FFF6@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 02/15/18 07:59, Luis R. Rodriguez wrote:
> curious if you ever got to adapt a test case for xfstests for your patch
> "fs: global sync to not clear error status of individual inodes", which
> got merged as of v4.4 as:
> 
> aa750fd71c242dba02ee2034e15fbd7d0cdb2461 mm/filemap.c: make global sync not clear error status of individual inodes
> 
> You said you'd work on it, so curious if you ever got to it.
> 
> [0] https://patchwork.kernel.org/patch/7183351/

I had adapted the test for xfstests and posted at the time but it
didn't go further. I guess recent kernel changes in this area also
added related test cases to xfstests.

  xfstests: test data-writeback error detection with fsync
  https://patchwork.kernel.org/patch/7194041/

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
