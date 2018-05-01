Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754283AbeEAJYU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:24:20 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2023 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753874AbeEAJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:24:19 -0400
Message-ID: <1525165387.23227.44.camel@petrovitsch.priv.at>
Subject: Re: Suggested new user link command
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To: Tony Wallace <tony@tony.gen.nz>, linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 11:03:07 +0200
In-Reply-To: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-debian-Metrics: esgaroth.tuxoid.at 1169; Body=2 Fuz1=2 Fuz2=2
X-Spam-Report: *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
        *  0.7 AWL AWL: Adjusted score from AWL reputation of From: address
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

On Tue, 2018-05-01 at 20:03 +1200, Tony Wallace wrote:
> I am suggesting a new command for linking files.  Currently there is
> no
> easy way to link a file with a known inode number to its correct
> position in the directory tree.  
> 
> 
> int ilink(const int inode, const char *newpath)

... avoiding any permission checks on all paths to the existing names.

> The current alternative to this command is to find the file path
> associated with an inode using the find command and then once found
> using a standard link command.  Obviously this is very inefficient.  

That's the price for security as it requires proper permissions.
Or is this a root-only syscall?

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
