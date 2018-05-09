Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965441AbeEIT2Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:28:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60745 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964931AbeEIT2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:28:14 -0400
Date: Wed, 9 May 2018 19:28:13 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/24] selftests: kmod: return Kselftest Skip code for
 skipped tests
Message-ID: <20180509192813.GT27853@wotan.suse.de>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-13-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505011328.32078-13-shuah@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 07:13:17PM -0600, Shuah Khan (Samsung OSG) wrote:
> When kmod test is skipped because of unmet dependencies and/or unsupported
> configuration, it returns 0 which is treated as a pass by the Kselftest
> framework. This leads to false positive result even when the test could
> not be run. It returns fail in some cases when test is skipped. Either way,
> it is incorrect and incosnistent reporting.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
