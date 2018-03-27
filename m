Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeC0MoW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:44:22 -0400
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:15264
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750944AbeC0MoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:44:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180321133040.6754c372@canb.auug.org.au>
 <20180321024556.GX2186@sirena.org.uk>
 <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
 <20180322013817.GY2186@sirena.org.uk>
 <3d47f2cb-0a73-98a7-bb3a-f40baf00123b@amd.com>
 <20180327112738.GA29239@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <1173f854-804a-0346-1f56-0999c5ce9f58@amd.com>
Date: Tue, 27 Mar 2018 18:15:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327112738.GA29239@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::29) To CY1PR12MB0309.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b15e588-025f-473e-c729-08d593e073ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0309;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;3:ZNLqQxTyqW3z6wItErQiZ1450EQyAE3U6tkRbn1BHATaFf5oZcwxi/znH7HysyMCdwCSQ3vSO8VH8LzBT7tOkPHbAqu3fFW18NOAdvwhryX8BOkrDuRkqWOd3sUUKHQRKXDA7CVzbrIdLHa/Tf+ikjVJtHBZzIcub69bXwusjcPyf4kbmG/NL761FMDxm1SzdHK0cC13/fApp0pMlpgyPyzHAwRx7fvOefLhuayzIHLqef0OD1lvqFcWr1tsQ/fW;25:LA4AkS7FCzQPlZfvT8Q7MQtxI1Rs3nXf5vCg8RIn3wkQj1Dpmlp6sgj99ZrBBRYaT66wFrnWCjsKt/7WUtxfACQ/RR9ChsI0Ukj2W4ToUdIC89br1O93LA9GHVOkVSnOof0e36ygW8hbHi7EgcB6wtkkO+IdE6/bKau6+nBmUbzrWko006MlniqHVFDj9w3DDm6ie7EpSRDycq4INDNrprOCAgF4QHI/NsZuaJTAR7VEnwmPGHUwTV92WLh3QJwluZcNVK7NpIgLNyt805UmsPCuahdstjvupOt07zhuHStjY/iJTUbRNsBjlL8GP5YQxP0Bpq3TQXsrTTlW38pgl4sgdICoIYartLEmnaKuiS0=;31:aAFMbK258Y1OlPYEyIP1o4xJNhJDb2nOB1yRR3mgqdIRnQC30i8S2G1sf2OjBLC1Zflu/PjfuZAR2bfwnpbGsxevEdU25p7Fcx/33pxg4n2AJTkpWmcoby5KxB/y3MJKWSp/n+HnjrYhFii+pCe2lPRjjz0bZZzXAArbtNBEo26HZcWQBZc+CHBrGCx89pvmP8UjHXF7FjFkXOMZvXntjysxf58aL5sYp9qxRLcl3Ho=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0309:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;20:NvD/3YCKeYx/PxYy5lCpBzw/IGnDAWqdXAger6aSRLehn7TfzTX832j2Mnmkv/bC1ut1cF+hLVkdOG0f6g+7gVezLGSYJmKi/V+41s5rSEmNB332UP8RZlq46To0mxu85KHNsy+tSPc2FubSFDoggIWBi7dlINLktycLvwML74XhHFNUSM9B2lCia5K7BZxhqGq8BVTf4/uI8Us55NhNOE9FBoTNKjugeoGWEDBkf7pE4ZV1WPcf4zQmw0YzBPqkNpr0GszLLjJe3bOeLtwLH4tdK6MAoJ+g98336ocVDJZRRTwR8dNhYbSLPO1vSNjgUPV8vZu8a9rZcnoY3fnm6EP9QPL5uT3TgltS/KPOMMAQaPJLMhA7H6DC+riYHo0eQEkuaQazTdKXfJDHnf5HuIG15vVFUWYK7+kG2vAra+brMz4QON8XR/gqvNZYnlVIwH8OA4hOdT7fr6a/XTYI3K99nHZZo9pIHG1M+osKqE/XEmaSBw3HD63Wtlz8tOl/;4:UT5edjRMeFCXdEGaalkQ0WG3sRDksOYfJoxSN9axCUJisBDZwnMROWNmQ8DTiRTihxjUnRunu455nEcwlzEKFeNSMoWd6GvOvKv4ztJI05FFxHVEpouwumoV/3ydOSBxMsIWlw2MDSrmYwqIGU92WB+F1AlAbRcZQ2uQqAErh2gEvmx7EkuHmiGe5HQgJEfIuunou0CJxMdEZpRKjgrzE8KDTQGqpzFOO6wSTxWZX2/dHn8NdSSZo+BzqPoVyrdDnOTqN+DYywcXZoKWxlcfWg==
X-Microsoft-Antispam-PRVS: <CY1PR12MB03091AA06A595147ABDB83DB97AC0@CY1PR12MB0309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0309;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0309;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(31696002)(64126003)(39060400002)(81166006)(6486002)(2616005)(6666003)(65826007)(446003)(956004)(478600001)(7736002)(25786009)(105586002)(966005)(2870700001)(386003)(476003)(5660300001)(11346002)(6246003)(4326008)(97736004)(31686004)(81156014)(76176011)(6916009)(305945005)(8936002)(72206003)(52116002)(86362001)(36756003)(53936002)(2906002)(6116002)(26005)(77096007)(67846002)(106356001)(47776003)(65806001)(6306002)(66066001)(16576012)(93886005)(58126008)(65956001)(8676002)(23746002)(486005)(3846002)(68736007)(229853002)(316002)(16526019)(50466002)(486005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0309;H:[10.129.12.246];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR12MB0309;23:6G+Er+5yD6fWpm8GR6Qw+WOXL/pCxJ/MvZSVx?=
 =?Windows-1252?Q?vHVlWJcy9k/bQrxubFiBiGYZOpL9HQ4nw8X/JE+y+ZgJnFn8UiHbrkbp?=
 =?Windows-1252?Q?mYWniIuz52CMdUMdbtYFOqhvDhqNPrmyaoH7e9HjqnwyGPK6aORnwXS5?=
 =?Windows-1252?Q?2Txyew0kc0aI0iaFdEP0FpPw7gyOSxwzUNBSEC63bnc929BN8Z7qL/4c?=
 =?Windows-1252?Q?u9URNuNidZS6mAP9IEn0fMFzMWJiqbOBFwLoQ2woyDo8wK3gLu+U7Cj3?=
 =?Windows-1252?Q?kxrUQkOXllXo6f0kV3KrInKVfC1e73k7/iMp5XwYn038Ckw69OkvhAKI?=
 =?Windows-1252?Q?rtR9wF+VUpw5WCKmZ42nxf2ue1Gjyx2c9CbbZxciJGpHpIeR1J3eS80u?=
 =?Windows-1252?Q?n5YnOyTZ0KouR7szHXozHjdsxX2gMiqHafvdoGE1LzqtE6+bljkBXq1B?=
 =?Windows-1252?Q?tueWYLvcFRuzS/d8CfFa0eIqCnnTDZN6CZR/ANcExmoSJ6EqdARl5H2c?=
 =?Windows-1252?Q?CaGrW4eHIryshXPhbc7VVlrADwDVp7Gt3trleP7EnFlFnKh34UMAEY/y?=
 =?Windows-1252?Q?qWN69/Sy9JM/PvVk8FcoSxPMd2BRiChRTVzW9iRWw+wOjDKneOfwcx21?=
 =?Windows-1252?Q?guxJmcXJb3dhXxWrck8g8fp45brIT/09HhVF+oIftQny7Iy4Xfnnp5aj?=
 =?Windows-1252?Q?qpK2uG1y0tVivvpxcqeECHC50VR4RrkQoPRed3M7Q/RA9UWSFmC6rr2e?=
 =?Windows-1252?Q?c/210+/KNy6fwhnXddN+TMAWPb1g8/BX/ycDp4Svjnn3flgOJFEo7an7?=
 =?Windows-1252?Q?4lhYs3I1VSYMtIEaR4kVZxkL3uNHMZlonOTwThVE2DexoaLxmOPziBy4?=
 =?Windows-1252?Q?M9Gwvi+lZP4eD3D7i9uELLOgUUgi932mfEWaAp19N1SyDoIMoBLU9TWI?=
 =?Windows-1252?Q?FT3YAX5Ukcn9jrzqYQNnQapn1Yt9SuOAk4vYZbJquijWU5XlxxzRTF4y?=
 =?Windows-1252?Q?rEEmVI24iyfseWjyy829WWT1w3RQdSKArb3LlDW9IVf6VAOMGdoaTK5r?=
 =?Windows-1252?Q?fXX9l9i/bgffcpxPJ6QRMhksXCgyJZrXSbHavD3/k5RttFxcGJOwM6Xd?=
 =?Windows-1252?Q?2b5atbkUE2bl1/MQxT1WP3cNnV2CbKGDU1r4pVvjx3yZmSiJg4xb+sjV?=
 =?Windows-1252?Q?npyuw2gDTQv3xXq8sFf4gwlstY2vKE8KDdDEdHa1bVmbyfqI4R05G0dV?=
 =?Windows-1252?Q?HEnM6GBGTXjVM8pJmEvWRYku30lafhJLQe/vvrZ0e4sjn9NP0s8djdsA?=
 =?Windows-1252?Q?UP6wln0tvc4MW06+gCDvFOzedeIwoRpzMLui1WbFktvNP7awFUQLaNMV?=
 =?Windows-1252?Q?8TmeK1LFLxI90y7kaI1tIWcaZBMb6UwnBjD0qQKZziEDM8gBvXOrPkOn?=
 =?Windows-1252?Q?ZvLzAp6RQCewUex3JvTCwvNcr8sYBdgTMiZJmkyu7yJZWlmXIE4Qf70h?=
 =?Windows-1252?Q?rDNR3RQg7GBCIdYhQDq4ACM78zwpyxAjnFBd2hT4zSYOUPWFb+Od7Rtz?=
 =?Windows-1252?Q?8IA38hZd36dLq3OEo7wjAaRJAzGA9pmLdse8Cfe0QLM9v+onlUbA7/X4?=
 =?Windows-1252?Q?P6X8ln3C1qn4CIJNXUQFEI=3D?=
X-Microsoft-Antispam-Message-Info: 1F5VssGN+naLi2ilYZ6wj1sTiOxppoC/pS3fu6rTX2XUdKKWsPpfeydCX3uIc15h9C9YQk7u3BvmFXiFsUQOON9pvSy3JPHjFsB8Jjg2mOY9/lf+joQbBgO1AsmR/JEElrVJf6YqPHjpCYcCizE9zf/qE7NMedsiwoMIa4GzYEcL3YdKeKJGNkeqkt4anivo
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;6:K43UKPcKhwyza+4dXHhKH7WnYbfgjBdnWcv5NDeIuhzhP8oEjjKkzO0dwJElrX/rjYoRkyt/0LCE1JgXKoVodWyCPwSu7XXgUktdUxs9Xv3dy0k+grAP0PSsTUxXvMGqHaBQ8wYG9zC/Rkor9OidjpoIL3ubYmfoBsjuCh3RbuufOahlmCa25Sn1xDtKXXXJd4vCmzrl5J77C2ydUk9AG2xboc0UjSH6MzpFhKBpT44OMl/Lico2ey8qAEKQs/gFk0DmcJoY3PgQj8d78tuAhzLOalisCbiy1Ty96Wl20wjt5P4tTMkSMN4SWIGoGGt2agU9ulp+F1YoePL5ZJhgiKMDaZJXy5mwSVFTsT53Kspq35998AIft5avWYXe0/YYHCi/8RRmvgD4PBItzgb+OFZ3aEkcqy3eLdV1CQoMEEflxFy8xTvPOoY01XHMS/MOEpA6Ka+qhFGlcSmjqanC0w==;5:dxiSuLcGAXT7aPmBdiUM11aJeVRfHDcIRjyHhcpvVwZ+q/yI1XawQc/ETkmaKFYMS1SGuh67AI+XxUVfTy92D5L44DoETPYr+9+fAoOgm2V7m3PimeO6yWXNvUSeGc95Pwk54mzc8rsz9tDFf5Y8nWCGDIuWa1zbvanPUl/r+TU=;24:TL2ZoEBXgF01ZOxDstilO85Xb3TSyXjiqEv8HxLINPCK+asXP0TIEhzWtZcLtKb1pJbBJDBogywdVdUsViL1/hE2Drt1lPI6PZsDWL6nefU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;7:khXXOjkVHSpKLo2qgYs5Lzvggn7xNCuF5rltk+HqSb5fO5tD+Y63oKAtSz6CmPvp4EQvs0Wpr0eDRh90NtRYp8gEOs7Layv3Hcx6SnYVtam1N92QLWSFLtb6hlUoZjssFtJ+olxJ0vFprmsVeerl7EONACfyZAcQzq/LUFyIxEBsUqmSXqCQUeiBz3HXRzNfDJPTeEDWNLzNZPiwa96AjqbjiWXO9P/DV6W2cLEiiqq7hmwWUgD9qCnpti3Ftovd;20:XKx8y4uemNDQsCcxBJzzd+CPY/KGvKrQBxHWD9tZ93SFEaD0oyIwksT/ybflsXZv/PgRSYczO0rozl2vq4vOy2QgeZswmDeIEi1KpU3roQE7sG5IYLDm9CWUz3+cPFvdNvyJQfKOceOVoi7f/ZgXvRFj7SEmtcwVqzf1AHQ28W1bIBlLI+x6JfwMt2Ngqzt9CQ5dhcw+ilxyWoiEkV0E/Z9IUZszwzuEGpCpfGMILNuBDC1kmyXS/85R/UK8z0wf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 12:44:14.2302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b15e588-025f-473e-c729-08d593e073ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 27 March 2018 04:57 PM, Mark Brown wrote:
> On Thu, Mar 22, 2018 at 11:24:43AM +0530, Mukunda,Vijendar wrote:
>> On Thursday 22 March 2018 07:08 AM, Mark Brown wrote:
> 
>>> You need to mention dependencies between patches when publishing and I
>>> don't seem to have a copy of that patch, according to the list archives
>>> Alex asked you to make some chnages to it.
> 
>>     Changes suggested by Alex already implemented and posted .
>>     Current patch (https://patchwork.kernel.org/patch/10298281/ ) is
>>     dependent on below patch.
> 
>>     https://patchwork.kernel.org/patch/10296597/
> 
> I'm working offline so these links aren't doing anything useful for me,
> sorry.

submitted fresh patch set which includes dependent patch.
Please ignore this mail thread.
> 
>>     We will publish patch dependencies while sending patches.
> 
> Please.
> 
